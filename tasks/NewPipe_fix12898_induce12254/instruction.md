# Code Review Task

You are a maintainer reviewing a pull request to the `TeamNewPipe/NewPipe` repository.

**PR title:** Player/handleIntent: Don’t delete queue when clicking on timestamp

**PR description / commit message:**

Player/handleIntent: Don’t delete queue when clicking on timestamp

Fixes https://github.com/TeamNewPipe/NewPipe/issues/11013

We finally are at the point where we can have good logic around
clicking on timestamps.

This is pretty straightforward:

1) if we are already playing the stream (usual case), we skip to the
   correct second directly
2) If we don’t have a queue yet, create a trivial one with the stream
3) If we have a queue, we insert the video as next item and start
  playing it.

The skipping logic in 1) is similar to the one further down in the old
optimization block, but will always correctly fire for timestamps now.
I copied it because it’s not quite the same code, and moving into a
separate method at this stage would complicate the code too much.

## Working environment

The repository is checked out at `/app/NewPipe` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
