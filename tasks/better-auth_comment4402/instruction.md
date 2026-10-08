# Code Review Task

You are a maintainer reviewing a pull request to the `better-auth/better-auth` repository.

**PR title:** feat(logger): option to disable colors

**PR description:**

This PR adds option to disable colors from default logger implementation.
I've made this change because convex doesn't support colors in logs (using https://convex-better-auth.netlify.app/)
Default logger implementations logs look like this:
<img width="711" height="112" alt="image" src="https://github.com/user-attachments/assets/fbcad63c-4df2-4f48-bdec-5348923b70d7" />
<img width="991" height="331" alt="image" src="https://github.com/user-attachments/assets/24119a02-a7b4-47bf-a6d8-7b5146bb452c" />

In this environment colors are not needed nor supported in convex dashboard.

No breaking changes introduces, only optional `disableColors` property for logger.
I have found no issues or discussions for this setting

    
<!-- This is an auto-generated description by cubic. -->
---

## Summary by cubic
Adds a disableColors option to the default logger so you can turn off ANSI colors in environments that don’t support them (e.g., Convex dashboard). Default behavior is unchanged; no breaking changes.

- New Features
  - logger.disableColors (default: false) to output plain-text logs without colors
  - Docs updated to include the new option in the logger configuration

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
