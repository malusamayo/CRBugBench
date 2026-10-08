# Code Review Task

You are a maintainer reviewing a pull request to the `astral-sh/uv` repository.

**PR title:** Fix backtick escaping for PowerShell

**PR description:**

## Summary
Fixes the logic for escaping a double quoted string in PowerShell by not escaping a backslash but escaping the Unicode double quote variants that PowerShell treats the same as the ASCII double quotes.

<img width="685" height="99" alt="image" src="https://github.com/user-attachments/assets/ac1368c2-d915-4e49-b67f-ac71ee0f7d46" />

## Test Plan
There does not seem to be any tests for this. I'm fairly new to rust but happy to add some if someone can point me in the right direction.

## Working environment

The repository is checked out at `/app/uv` at this PR's **base commit**
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
