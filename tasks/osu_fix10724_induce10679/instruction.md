# Code Review Task

You are a maintainer reviewing a pull request to the `ppy/osu` repository.

**PR title:** Add the ability to delete slider control points using shift+right click

**PR description / commit message:**

Add the ability to delete slider control points using shift+right click

Closes https://github.com/ppy/osu/issues/10672.

In two minds about how this should be implemented but went in this
direction initially. The other way would be to add local handling of
Shift-Right Click inside PathControlPointPiece (which is already doing
mouse handling itself).

## Working environment

The repository is checked out at `/app/osu` at this PR's **base commit**
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
