# Code Review Task

You are a maintainer reviewing a pull request to the `redis/redis-py` repository.

**PR title:** fix: detect closed pooled connection without consuming pending push data (RESP3 + hiredis) (#4128)

**PR description:**

### Description of change

Fixes #4128.

With `redis[hiredis]` installed and `protocol=3` (the default since 8.0.0), a
pooled connection closed by the server is not recovered, and the next command
raises `ConnectionError: Connection closed by server.` instead of transparently
reconnecting. The issue matrix isolates it to protocol=3 + hiredis; protocol=2 +
hiredis and protocol=3 + pure-Python RESP3 both recover.

The root cause is that the hiredis parser could not tell a server-closed socket
apart from one holding pending data. A closed socket reads as ready (it yields
EOF), so `can_read()` reported it readable, the pool handed it back, and the next
command failed. The pure-Python parser already signals this by `recv()` returning
`b""`, and the async hiredis parser by `StreamReader.at_eof()` — the sync hiredis
parser had no equivalent, so the three parsers were out of line.

The fix adds a non-destructive `_socket_is_closed()` helper and calls it from
`_HiredisParser.can_read()`: when the socket reports readable but the reader has
no buffered data, it distinguishes a pending push from a peer-closed socket and
raises `ConnectionError(SERVER_CLOSED_CONNECTION_ERROR)` on close. The existing
pool-checkout guard in `ConnectionPool.get_connection()` catches that error and
triggers its disconnect-and-reconnect path, so a readable-but-open connection
under client-side caching or maintenance notifications still keeps its pending
push, while a genuinely closed one is recycled. This keeps the change contained
to the parser and avoids expanding the public connection interface.

Closure is decided by a non-destructive `MSG_PEEK` whenever the socket polls
readable (EOF peeks as `b""` on every runtime), which settles cases the poll
flags alone cannot: `POLLHUP`/`POLLRDHUP` can be reported while unread data is
still buffered, and a drained closed socket reports plain `POLLIN` where
`POLLRDHUP` is unavailable (PyPy). Pending data — including RESP3 push messages
such as cache invalidations — is therefore fully processed before the connection
is treated as closed, matching the pure-Python parser. `POLLRDHUP` is registered
on Linux (guarded with `getattr(select, "POLLRDHUP", 0)`, so macOS/Windows keep
relying on `POLLHUP`) to cover graceful peer half-close, and TLS sockets fall back
to poll flags since their buffered plaintext is covered by the `pending()` check.

This is sync-only by design: the async pool's `can_read()` already detects EOF
via `StreamReader.at_eof()`, so the async stack recovers without changes. New
tests use real TCP socket pairs (an `AF_UNIX` socketpair sets `POLLHUP` on close
and would hide the Linux FIN path) to cover peer close, Linux half-close,
deferring closure until buffered push data is drained, the no-`poll()` fallback,
and the pending-SSL-data case.

### Changes

- Add `_socket_is_closed()` to `redis/_parsers/hiredis.py`: a non-destructive
  `poll()` + `MSG_PEEK` check that reports whether a readable socket is
  peer-closed, with `POLLRDHUP` handling for Linux graceful FIN and a `pending()`
  guard for buffered TLS plaintext.
- Have `_HiredisParser.can_read()` raise `ConnectionError(SERVER_CLOSED_CONNECTION_ERROR)`
  when the socket is readable, the reader has no buffered data, and the socket is
  closed — bringing the sync hiredis parser in line with the pure-Python and
  async parsers.
- Add regression tests in `tests/test_connection.py` covering peer close, Linux
  TCP half-close, pending-push-before-close, the no-`poll()` fallback, and
  pending SSL data.

### Pull Request check-list

_Please make sure to review and check all of these items:_

- [x] Do tests and lints pass with this change?
- [x] Do the CI tests pass with this change (enable it first in your forked repo and wait for the github action build to finish)?
- [x] Is the new or changed code fully tested?
- [x] Is a documentation update included (if this change modifies existing APIs, or introduces new ones)? - NA
- [x] Is there an example added to the examples folder (if applicable)? - NA

_NOTE: these things are not required to open a PR and can be done
afterwards / while the PR is open._

<!-- CURSOR_SUMMARY -->
---

> [!NOTE]
> **Medium Risk**
> Touches connection lifecycle on every hiredis readiness check (poll/peek/SSL paths); behavior is platform-dependent where poll is absent, but covered by extensive tests and aligned with other parsers.
> 
> **Overview**
> Fixes **#4128** for the sync **hiredis** parser when RESP3 leaves the socket readable with no hiredis buffer (server FIN vs pending push).
> 
> Adds **`_socket_is_closed()`**, a non-destructive check using **`select.poll()`** (with **`POLLRDHUP`** on Linux), optional **`MSG_PEEK`**, and SSL **`pending()`** handling so buffered push/invalidation bytes are not treated as closed. Without **`poll()`** (e.g. Windows), it conservatively reports not closed.
> 
> **`_HiredisParser.can_read()`** now raises **`ConnectionError`** when the socket is ready but empty and the peer has closed—matching pure-Python/async behavior so pools can recycle stale connections—while still returning **`True`** for readable open sockets with pending data.
> 
> Tests cover peer close, TCP half-close, data-then-close, SSL pending, and integration with **`can_read()`** / push reads.
> 
> <sup>Reviewed by [Cursor Bugbot](https://cursor.com/bugbot) for commit 55d41593d3795080cdfc090ed56c19d9ab4ea3b1. Bugbot is set up for automated code reviews on this repo. Configure [here](https://www.cursor.com/dashboard/bugbot).</sup>
<!-- /CURSOR_SUMMARY -->

## Working environment

The repository is checked out at `/app/redis-py` at this PR's **base commit**
(the state before this PR), and the proposed change is present two ways:

- applied as **uncommitted modifications** to the working tree (run `git diff`
  to see it, or use a review tool that inspects the local git diff), and
- saved as a unified diff at `/app/pr_to_review.diff`.

Use `git log` and `git show HEAD:<path>` (HEAD is the base commit) for
surrounding history, call sites, and conventions.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
