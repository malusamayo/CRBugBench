# Code Review Task

You are a maintainer reviewing a pull request to the `SeleniumHQ/selenium` repository.

**PR title:** Add support for creating and removing virtual authenticators (#7760)

**PR description / commit message:**

Add support for creating and removing virtual authenticators (#7760)

This patch adds support for the Virtual Authenticators WebDriver API,
allowing developers to write E2E tests that exercise the WebAuthn API.
At the moment, the API is only supported on Chrome 79 onwards.

Fixes #7753

[1] https://w3c.github.io/webauthn#sctn-automation

## Working environment

The repository is checked out at `/app/selenium` at this PR's **base commit**
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
