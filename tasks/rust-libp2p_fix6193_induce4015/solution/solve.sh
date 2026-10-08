#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `transports/webtransport-websys/src/stream.rs`:

This pull request introduces the defect later reported as "Closed stream is polled causing debug assertion to fail for WebTransport in wasm". The
problem a user observed, and its root cause:

### Summary

I'm connecting to a peer over WebTransport in a browser. When running release builds app is behaving correctly. Debug builds (including tests) on the other hand fail shortly after connecting. In browser console I see panic, which seems to be coming from [this debug_assert](https://github.com/libp2p/rust-libp2p/blob/master/transports/webtransport-websys/src/stream.rs#L152). Additionally when I change the debug_assert to panic, release builds also fail. 
Rest of the libp2p seems to continue in a degraded state, as I see logs from e.g. running behaviours.

### Expected behavior

I expected debug builds to work same as release, where the behaviour is able to correctly send the request and get a response.

### Actual behavior

Behaviour seems to hang indefinitely, I'm guessing it's waiting to send/flush

### Relevant log output

_No response_

### Possible Solution

I guess removing the assert or making sure that closed stream isn't polled would fix it, but I don't know enough about libp2p to know which would be the correct solution.

### Version

tag: v0.54.1

### Would you like to work on fixing this bug ?

Yes

This same root cause must be fixed before merging.
REVIEW_EOF
