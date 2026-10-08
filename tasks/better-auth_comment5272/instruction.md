# Code Review Task

You are a maintainer reviewing a pull request to the `better-auth/better-auth` repository.

**PR title:** feat: Improved API error page

**PR description:**

This PR introduces an improved API error page, as well as documentation for all of the common error codes seen on the api error page.

Added customizability to configure error page colors and other aspects.
Added support in the docs to check for a `askai` query param to auto-open the ask ai UI and prompt the bot based on the query param.
Added functionality in the error page to auto redirect to the auth config defiend error URL if it's defined, and to not show the BA error page if on production unless it's customized.

## It uses light mode by default, unless it's able to detect system preference
https://github.com/user-attachments/assets/f0e9e55a-eb2e-4cc6-8d0f-53ccacaf42e2



    


















<!-- This is an auto-generated description by cubic. -->
---
## Summary by cubic
Redesigned the API auth error page with clearer messaging, customization, and docs for common OAuth errors to speed up debugging.
The /api/auth/error endpoint now shows the error code and optional description, adds Ask AI and doc links, and redirects to a configured error URL or home in production when appropriate.

- **New Features**
  - Modernized /api/auth/error UI with code badge, optional description, and Go home + Ask AI actions.
  - Links each error to detailed docs at /docs/errors/<code>; unknown codes fall back to /docs/errors/unknown; docs support an askai query param to auto-open help.
  - Endpoint reads error and error_description query params and safely renders them.
  - Added auth config options to customize the default error page (colors, fonts, sizes, and decorations).
  - Redirects to onAPIError.errorURL if set; on production, auto-redirects to home unless the default page is customized.

<sup>Written for commit 9f3fc65714db5d79185ab8407e3bf31570229f21. Summary will update automatically on new commits.</sup>

<!-- End of auto-generated description by cubic. -->

## Working environment

The repository is checked out at `/app/better-auth` at this PR's **base commit**
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
