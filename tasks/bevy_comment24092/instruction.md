# Code Review Task

You are a maintainer reviewing a pull request to the `bevyengine/bevy` repository.

**PR title:** Feathers scrollbar and list view.

**PR description:**

# Objective

Part of #19236 

## Solution

Implementation of scrollbars and list views for Feathers.

## Testing

Manual testing:
* click to select
* wheel scrolling
* tab and keyboard navigation

## Showcase

<img width="380" height="182" alt="listbox" src="https://github.com/user-attachments/assets/d3f902cd-0c73-475f-806b-d6ccb5ea3cac" />

## Working environment

The repository is checked out at `/app/bevy` at this PR's **base commit**
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
