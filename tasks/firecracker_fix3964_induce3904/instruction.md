# Code Review Task

You are a maintainer reviewing a pull request to the `firecracker-microvm/firecracker` repository.

**PR title:** chore: Add kani to the devctr

**PR description / commit message:**

chore: Add kani to the devctr

Add kani to devctr because we're adding kani to our CI

Signed-off-by: Patrick Roy <roypat@amazon.co.uk>

## Working environment

The repository is checked out at `/app/firecracker` at this PR's **base commit**
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
