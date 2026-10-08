# Code Review Task

You are a maintainer reviewing a pull request to the `better-auth/better-auth` repository.

**PR title:** fix(passkey): ensure addPasskey returns passkey data instead of undefined

**PR description:**

## Description

Fixes an issue where `client.passkey.addPasskey()` was returning `undefined` instead of the passkey data when registration succeeded.

## Changes

- Added missing `return verified;` statement in the `registerPasskey` function's success path
- The function now correctly returns the passkey data from the server response
- No breaking changes to the API contract

## Problem

The `addPasskey` client method was missing a return statement after successful passkey registration. This caused the function to return `undefined` instead of the expected passkey data, making it impossible for consumers to access information about the newly created passkey.








<!-- This is an auto-generated description by cubic. -->
---
## Summary by cubic
Ensures client.passkey.addPasskey returns the passkey data on successful registration instead of undefined.

- **Bug Fixes**
  - Added missing return after list refresh so the verified passkey is returned.
  - Updated verify-registration fetch to use Passkey as the response type.
  - No breaking changes to the API.

<sup>Written for commit 8ccfc36cca05ee3e61183ed0cb64863c65b6f91b. Summary will update automatically on new commits.</sup>

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
