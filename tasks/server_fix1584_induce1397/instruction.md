# Code Review Task

You are a maintainer reviewing a pull request to the `bitwarden/server` repository.

**PR title:** Allow for changing database name (#1397)

**PR description / commit message:**

Allow for changing database name (#1397)

* Remove hard coded database name

* Update permissions on build scripts

* Update Setup project and run scripts for configuring database name

* Remove hyphen from database name flag

* Update with suggested changes, still needs testing

* Revert SQL statements to concatenantion for testing

* Fix typo

* Update util/Setup/EnvironmentFileBuilder.cs

Co-authored-by: Chad Scharf <3904944+cscharf@users.noreply.github.com>

* Update SQL commands to prevent SQL injection attacks

Co-authored-by: Chad Scharf <3904944+cscharf@users.noreply.github.com>

## Working environment

The repository is checked out at `/app/server` at this PR's **base commit**
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
