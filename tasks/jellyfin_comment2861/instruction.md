# Code Review Task

You are a maintainer reviewing a pull request to the `jellyfin/jellyfin` repository.

**PR title:** Fix Auth Response Codes

**PR description:**

The server doesn't always return the correct HTTP response code for authentication and authorization errors. This PR cleans this up so that the server always returns the correct response code for the situation. This PR is paired with https://github.com/jellyfin/jellyfin-web/pull/1083 to make the necessary changes in the web client.

**Changes**
* Use `AuthenticationException` to return a 401 status code
* Use `SecurityException` to return a 403 status code
* Update existing auth logic to throw the correct exception for each circumstance
* Only show the ASP developer exception page for 500 server errors
* Do not send the exception message to the client for `AuthenticationException` as this could be abused to harvest usernames, etc.
* Throw `AuthenticationException` instead of `ArgumentNullException` if a username does not exist. This returns a 401 now instead of 500 and the client can display the correct error message for an invalid username

**Issues**
Fixes #2941

## Working environment

The repository is checked out at `/app/jellyfin` at this PR's **base commit**
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
