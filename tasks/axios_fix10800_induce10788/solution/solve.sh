#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `lib/adapters/http.js`:

This pull request introduces the defect later reported as "TLSSocket MaxListenersExceededWarning under concurrent keep-alive requests since v1.15.1 (PR #10576)". The
problem a user observed, and its root cause:

### Bug description

Since upgrading from v1.13.6 to v1.15.1, our production service emits Node's `MaxListenersExceededWarning: 11 error listeners added to [TLSSocket]` under bursts of concurrent HTTPS requests sharing a pooled keep-alive agent. The warning traces to the `'error'` listener added per request in the http adapter's `req.on('socket', ...)` handler, introduced by #10576 (commit 8b68491, first shipped in v1.15.1).

```
(node:12) MaxListenersExceededWarning: Possible EventEmitter memory leak detected. 11 error listeners added to [TLSSocket]. MaxListeners is 10. Use emitter.setMaxListeners() to increase limit
```

### Root cause (hypothesis)

The fix in #10576 attaches a per-request socket error listener and schedules removal on `req.once('close', ...)`:

```js
req.on('socket', function handleRequestSocket(socket) {
  socket.setKeepAlive(true, 1000 * 60);

  const removeSocketErrorListener = () => {
    socket.removeListener('error', handleRequestSocketError);
  };

  function handleRequestSocketError(err) {
    removeSocketErrorListener();
    if (!req.destroyed) {
      req.destroy(err);
    }
  }

  socket.on('error', handleRequestSocketError);
  req.once('close', removeSocketErrorListener);
});
```

Under keep-alive, Node's `https.Agent` can reassign a freed socket to a queued request **before** the previous request's `'close'` event fires:

1. Request A response ends → socket moves to the free pool
2. Agent reassigns the socket to queued Request B → B's `'socket'` event fires → **listener 2 added**
3. Request A's `'close'` finally emits → removes listener 1

Steps 2→3 race. With N concurrent requests to the same host sharing a single pooled TLSSocket, the listener count can peak well above 1 before all `close` events drain. Once it crosses the default `MaxListeners=10`, Node warns.

### Steps to reproduce

```js
const https = require('https');
const axios = require('axios');

const agent = new https.Agent({ keepAlive: true, maxSockets: 1 });

async function main() {
  const client = axios.create({ httpsAgent: agent });
  // 15 concurrent requests funneled through one pooled socket
  await Promise.all(
    Array.from({ length: 15 }, () => client.get('https://example.com/'))
  );
}

main().catch(console.error);
```

Run with `node --trace-warnings repro.js`. On axios `1.15.1`, `MaxListenersExceededWarning` fires. On `1.15.0` or earlier, it doesn't.

### Expected behavior

No listener accumulation on pooled keep-alive sockets during normal concurrent usage.

### Actual behavior

Listener count on a single `TLSSocket` exceeds 10 during concurrent bursts; Node emits `MaxListenersExceededWarning`.

### Environment

- **axios**: 1.15.1 (fails); 1.13.6–1.15.0 (works)
- **Node.js**: observed on v24.x; likely reproducible on any current LTS
- **Pattern**: high-concurrency HTTPS client with `new https.Agent({ keepAlive: true })`

### Verification

```
$ gh api repos/axios/axios/compare/v1.15.0...8b68491 --jq .status
ahead
$ gh api repos/axios/axios/compare/v1.15.1...8b68491 --jq .status
behind
```

Commit `8b68491` is absent from v1.15.0 and present in v1.15.1.

### Workaround for affected users

- Pin to `axios@1.15.0` (last release without the regressing commit), or
- `new https.Agent({ keepAlive: true, maxSockets: N })` with N sized to real concurrency peak — limits how many pending requests can race onto a single socket, but doesn't fix the underlying race.

This same root cause must be fixed before merging.
REVIEW_EOF
