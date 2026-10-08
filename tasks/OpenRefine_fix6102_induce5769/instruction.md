# Code Review Task

You are a maintainer reviewing a pull request to the `OpenRefine/OpenRefine` repository.

**PR title:** open project: move tag filter state from URL hash to query params (#5769)

**PR description / commit message:**

open project: move tag filter state from URL hash to query params (#5769)

The ability to filter projects by tags uses URL-hashes for managing state, this, however interferes with the home screen panel links introduced in OpenRefine#5597. This change therefor, moves the filtering state to query params.

Side effects:
 -  you can now link to a tag filter
 - fixed some bugs caused by naming a tag "all"
 - ensured that OpenRefine's URL utility does not overwrite the native URL class.

## Working environment

The repository is checked out at `/app/OpenRefine` at this PR's **base commit**
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
