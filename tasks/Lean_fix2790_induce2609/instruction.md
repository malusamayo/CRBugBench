# Code Review Task

You are a maintainer reviewing a pull request to the `QuantConnect/Lean` repository.

**PR title:** Creating new Synchronizer - TimeSlice streamer

**PR description / commit message:**

Creating new Synchronizer - TimeSlice streamer

- Creating new `Synchronizer` which will consolidate and combine `TimeSlice`
streaming for both live and backtests modes. Will live in front of the
`DataManager`
- `SubscriptionSynchronizer` will be the `FrontierTimeProvider` exposed,
and owned, by the new `Synchronizer`
- Updating existing tests

## Working environment

The repository is checked out at `/app/Lean` at this PR's **base commit**
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
