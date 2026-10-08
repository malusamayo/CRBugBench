# Code Review Task

You are a maintainer reviewing a pull request to the `keycloak/keycloak` repository.

**PR title:** Fix totp manual link for proxy mode

**PR description:**

This PR fixes the totp manual mode url when using keycloak behind a reverse proxy.

Unfortunately I haven't been able to write a test for this very special case. However, I have manually tested my implementation responsibly. Please let me know if you have any ideas on how to simulate a reverse proxy within the tests.

Closes #11774

<!---
Please read https://github.com/keycloak/keycloak/blob/main/CONTRIBUTING.md and follow these guidelines when contributing to Keycloak
-->

## Working environment

The repository is checked out at `/app/keycloak` at this PR's **base commit**
(the state before this PR), and the proposed change is present two ways:

- applied as **uncommitted modifications** to the working tree (run `git diff`
  to see it, or use a review tool that inspects the local git diff), and
- saved as a unified diff at `/app/pr_to_review.diff`.

Use `git log` and `git show HEAD:<path>` (HEAD is the base commit) for
surrounding history, call sites, and conventions.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
