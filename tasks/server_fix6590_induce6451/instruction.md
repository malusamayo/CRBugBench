# Code Review Task

You are a maintainer reviewing a pull request to the `bitwarden/server` repository.

**PR title:** [PM-22992] Check cipher revision date when handling attachments (#6451)

**PR description / commit message:**

[PM-22992] Check cipher revision date when handling attachments (#6451)

* Add lastKnownRevisionDate to Attachment functions

* Add lastKnownRevisionDate to attachment endpoints

* Change lastKnownCipherRevisionDate to lastKnownRevisionDate for consistency

* Add tests for RevisionDate checks in Attachment endpoints

* Improve validation on lastKnownRevisionDate

* Harden datetime parsing

* Rename ValidateCipherLastKnownRevisionDate - removed 'Async' suffix

* Cleanup and address PR feedback

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
