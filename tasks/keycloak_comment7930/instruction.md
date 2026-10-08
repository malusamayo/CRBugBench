# Code Review Task

You are a maintainer reviewing a pull request to the `keycloak/keycloak` repository.

**PR title:** KEYCLOAK-17784: URL encode Keycloak's remember-me cookie to allow non-ascii usernames.

**PR description:**

International users using non-ascii symbols such as the german `äöü`
will make Keycloak set the KEYCLOAK_REMEMBER_ME cookie without URL
encoding. This will trigger an java.lang.IllegalArgumentException:
UT000173 exception in undertow's cookie parser which does not
allow non-ascii characters.

Co-authored-by: Fabian Freyer <mail@fabianfreyer.de>

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
