# Code Review Task

You are a maintainer reviewing a pull request to the `open-metadata/OpenMetadata` repository.

**PR title:** UI: Improvements and bug fixes for 0.12 part-3 (#7298)

**PR description / commit message:**

UI: Improvements and bug fixes for 0.12 part-3 (#7298)

* - Fixed profile pic not showing issue when image url returns error status
- Fixed switch in tasks drawer
- Fixed alignments and styling in tables

* Fixed failing unit tests

## Working environment

The repository is checked out at `/app/OpenMetadata` at this PR's **base commit**
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
