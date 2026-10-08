# Code Review Task

You are a maintainer reviewing a pull request to the `bitwarden/server` repository.

**PR title:** fix(2fa): [PM-22323] Do not show 2FA warning for 2FA setup and login emails

**PR description / commit message:**

fix(2fa): [PM-22323] Do not show 2FA warning for 2FA setup and login emails

* Added configuration to not display 2FA setup instruction

* Refactored to new service.

* Linting.

* Dependency injection

* Changed to scoped to have access to ICurrentContext.

* Inverted logic for EmailTotpAction

* Fixed tests.

* Fixed tests.

* More tests.

* Fixed tests.

* Linting.

* Added tests at controller level.

* Linting

* Fixed error in test.

* Review updates.

* Accidentally deleted imports.

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
