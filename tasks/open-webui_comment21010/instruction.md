# Code Review Task

You are a maintainer reviewing a pull request to the `open-webui/open-webui` repository.

**PR title:** perf: replace double lookup with single JOIN in authenticate_user_by_email

**PR description:**

## Summary
Eliminates double database lookup in authenticate_user_by_email. Previously, the function queried the Auth table first, then fetched the User separately.
## Changes
models/auths.py authenticate_user_by_email:
- Import User model
- Replace two separate queries with single JOIN query
- Auth and User tables joined on id, filtered by email and active status
## Performance Impact
Before: 2 queries (Auth lookup + User lookup)
After: 1 query using SQL JOIN

### Contributor License Agreement

By submitting this pull request, I confirm that I have read and fully agree to the [Contributor License Agreement (CLA)](https://github.com/open-webui/open-webui/blob/main/CONTRIBUTOR_LICENSE_AGREEMENT), and I am providing my contributions under its terms.

> [!NOTE]
> Deleting the CLA section will lead to immediate closure of your PR and it will not be merged in.

## Working environment

The repository is checked out at `/app/open-webui` at this PR's **base commit**
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
