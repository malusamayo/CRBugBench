# Code Review Task

You are a maintainer reviewing a pull request to the `dotnet/maui` repository.

**PR title:** Force parent invalidation on Margin and LayoutOptions changes

**PR description:**

### Description of Change

LayoutOptions and Margins effectively require a re-layout of the parent layout (if one exists) when they change. On some platforms, a layout request on the immediately affected control is sufficient, but others may have optimizations which defeat our need to update the layout when these properties change.

This change bumps the invalidation to the parent when LayoutOptions or Margins change.

### Issues Fixed

Fixes #4145

## Working environment

The repository is checked out at `/app/maui` at this PR's **base commit**
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
