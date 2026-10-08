# Code Review Task

You are a maintainer reviewing a pull request to the `netty/netty` repository.

**PR title:** Correctly handle http2 upgrades when Http2FrameCodec is used together…

**PR description:**

… with Http2MultiplexHandler

Motivation:

In the latest release we introduced Http2MultiplexHandler as a replacement of Http2MultiplexCodec. This did split the frame parsing from the multiplexing to allow a more flexible way to handle frames and to make the code cleaner. Unfortunally we did miss to special handle this in Http2ServerUpgradeCodec and so did not correctly add Http2MultiplexHandler to the pipeline before calling Http2FrameCodec.onHttpServerUpgrade(...). This did lead to the situation that we did not correctly receive the event on the Http2MultiplexHandler and so did not correctly created the Http2StreamChannel for the upgrade stream. Because of this we ended up with an NPE if a frame was dispatched to the upgrade stream later on.

Modifications:

- Correctly add Http2MultiplexHandler to the pipeline before calling Http2FrameCodec.onHttpServerUpgrade(...)
- Add unit test

Result:

Fixes https://github.com/netty/netty/issues/9314.

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
