# Code Review Task

You are a maintainer reviewing a pull request to the `netty/netty` repository.

**PR title:** SslHandler flushing with TCP Fast Open fix

**PR description:**

Motivation:
SslHandler owns the responsibility to flush non-application data
(e.g. handshake, renegotiation, etc.) to the socket. However when
TCP Fast Open is supported but the client_hello cannot be written
in the SYN the client_hello may not always be flushed. SslHandler
may not wrap/flush previously written/flushed data in the event
it was not able to be wrapped due to NEED_UNWRAP state being
encountered in wrap (e.g. peer initiated renegotiation).

Modifications:
- SslHandler to flush in channelActive() if TFO is enabled and
  the client_hello cannot be written in the SYN.
- SslHandler to wrap application data after non-application data
  wrap and handshake status is FINISHED.
- SocketSslEchoTest only flushes when writes are done, and waits
  for the handshake to complete before writing.

Result:
SslHandler flushes handshake data for TFO, and previously flushed
application data after peer initiated renegotiation finishes.

## Working environment

The repository is checked out at `/app/netty` at this PR's **base commit**
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
