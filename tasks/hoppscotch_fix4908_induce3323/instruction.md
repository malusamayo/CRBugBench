# Code Review Task

You are a maintainer reviewing a pull request to the `hoppscotch/hoppscotch` repository.

**PR title:** fix: missing baseurl on import openapi (#3323)

**PR description / commit message:**

fix: missing baseurl on import openapi (#3323)

* fix: missing baseurl on import openapi

* fix: url parser for openapi v3

* chore: revert to baseURL for cases where doc servers is present but url is null

---------

Co-authored-by: Andrew Bastin <andrewbastin.k@gmail.com>

## Working environment

The repository is checked out at `/app/hoppscotch` at this PR's **base commit**
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
