# Code Review Task

You are a maintainer reviewing a pull request to the `ManimCommunity/manim` repository.

**PR title:** Un-deprecated GraphScene (will be deprecated later), fixed an old-style call to NumberPlane (#1430)

**PR description / commit message:**

Un-deprecated GraphScene (will be deprecated later), fixed an old-style call to NumberPlane (#1430)

* un-deprecate GraphScene

* x_range, y_range shouldn't be numpy arrays

* revert NumberPlane box and minor changes to other classes

* replace width in config with x_length

* fix docs

* fix tests

* remove failing test temporarily

Co-authored-by: hydrobeam <laithbahodi@gmail.com>

## Working environment

The repository is checked out at `/app/manim` at this PR's **base commit**
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
