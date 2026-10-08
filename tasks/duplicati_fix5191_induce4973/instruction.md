# Code Review Task

You are a maintainer reviewing a pull request to the `duplicati/duplicati` repository.

**PR title:** Fix hidden username and password options when changing backends. (#4973)

**PR description / commit message:**

Fix hidden username and password options when changing backends. (#4973)

Remove username and password from target options if the backend does not show the input fields.

The username and password options are stored in different variables than the other backend options. Therefore, they are only visible if the backend supports them.

Closes #3082

## Working environment

The repository is checked out at `/app/duplicati` at this PR's **base commit**
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
