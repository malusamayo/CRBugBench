# Code Review Task

You are a maintainer reviewing a pull request to the `actualbudget/actual` repository.

**PR title:** Goals: Schedule multi month forecasting (#1452)

**PR description / commit message:**

Goals: Schedule multi month forecasting (#1452)

References discord discussion starting here:
https://discord.com/channels/937901803608096828/940290142579605514/1133523705063030824

Currently the schedule keyword won't fill any future budget cells if the
category balance already satisfies the schedule. This PR is an attempt
to improve the behavior by allowing budget fills regardless of the
category balance.

This is a drastic rewrite of the schedule keyword. Though I've tried not
to have any regressions, it is possible because of how different the
logic is. I've tested compounding using a simple template, so a small
change in the 'by' keyword was also made.

## Working environment

The repository is checked out at `/app/actual` at this PR's **base commit**
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
