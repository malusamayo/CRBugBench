# Code Review Task

You are a maintainer reviewing a pull request to the `nodejs/node` repository.

**PR title:** buffer: introduce Blob

**PR description / commit message:**

buffer: introduce Blob

The `Blob` object is an immutable data buffer. This is a first step
towards alignment with the `Blob` Web API.

Signed-off-by: James M Snell <jasnell@gmail.com>

PR-URL: https://github.com/nodejs/node/pull/36811
Reviewed-By: Antoine du Hamel <duhamelantoine1995@gmail.com>
Reviewed-By: Matteo Collina <matteo.collina@gmail.com>
Reviewed-By: Benjamin Gruenbaum <benjamingr@gmail.com>

## Working environment

The repository is checked out at `/app/node` at this PR's **base commit**
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
