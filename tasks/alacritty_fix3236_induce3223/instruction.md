# Code Review Task

You are a maintainer reviewing a pull request to the `alacritty/alacritty` repository.

**PR title:** Fix first cell when selection is off screen

**PR description / commit message:**

Fix first cell when selection is off screen

Since the expansion of the selection was done after clamping it to the
grid, the selection would incorrectly move the clamped start over by one
cell when the start was to the right of the original column. By
resetting the side of the start point to `Left` before expanding, this
can be circumvented.

This also resolves a regression which broke backwards bracket selection.

Fixes #3223.

## Working environment

The repository is checked out at `/app/alacritty` at this PR's **base commit**
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
