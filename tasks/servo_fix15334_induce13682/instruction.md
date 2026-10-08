# Code Review Task

You are a maintainer reviewing a pull request to the `servo/servo` repository.

**PR title:** Integrate stacking contexts into the display list

**PR description / commit message:**

Integrate stacking contexts into the display list

Integrate stacking contexts into the display list by adding two new
entry types, PushStackingContext and PopStackingContext. This allows us
to eliminate the ugly offsets map that DisplayList used to contain
and seems to speed up display list construction. With this approach
we are able to also completely prune pseudo-stacking contexts from the
final display list and remove their (minimal) overhead from display
list traversal Traversing the display list is also a bit simpler now.

Additionally, this will allow easier editing of the DisplayList to
properly support scrolling roots. The push/pop entries can be
duplicated to clone complex StackingContext trees between layers.

## Working environment

The repository is checked out at `/app/servo` at this PR's **base commit**
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
