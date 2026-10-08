# Code Review Task

You are a maintainer reviewing a pull request to the `langgenius/dify` repository.

**PR title:** refactor: migrate marketplace.py from requests to httpx

**PR description:**

> [!IMPORTANT]
>
> 1. Make sure you have read our [contribution guidelines](https://github.com/langgenius/dify/blob/main/CONTRIBUTING.md)
> 2. Ensure there is an associated issue and you have been assigned to it
> 3. Use the correct syntax to link this PR: `Fixes #<issue number>`.

## Summary

Started migrating from `requests` to `httpx` as part of the async/await modernization effort. This is a gradual migration - I'm starting with smaller, independent files to avoid breaking things.

Related to issue #24006 #23647

## Screenshots

| Before | After |
|--------|-------|
| ...    | ...   |

## Checklist

- [ ] This change requires a documentation update, included: [Dify Document](https://github.com/langgenius/dify-docs)
- [x] I understand that this PR may be closed in case there was no previous discussion or issues. (This doesn't apply to typos!)
- [x] I've added a test for each change that was introduced, and I tried as much as possible to make a single atomic change.
- [x] I've updated the documentation accordingly.
- [x] I ran `dev/reformat`(backend) and `cd web && npx lint-staged`(frontend) to appease the lint gods

## Working environment

The repository is checked out at `/app/dify` at this PR's **base commit**
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
