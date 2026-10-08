# Code Review Task

You are a maintainer reviewing a pull request to the `ManimCommunity/manim` repository.

**PR title:** Update Black checking process and fix output in PR

**PR description:**

## List of Changes
- Make Black check only modified file
- Fix errors in a PR comments.

## Motivation
- Tests are failing and should be passed.

## Testing Status
Tested in my fork https://github.com/naveen521kk/manim/pull/23 and https://github.com/naveen521kk/manim/pull/24

## Acknowledgement
- [x] I have read the [Contributing Guidelines](https://github.com/ManimCommunity/manim/wiki/Documentation-guidelines-(WIP))

<!-- Once again, thanks for helping out by contributing to manim! -->

## Working environment

The repository is checked out at `/app/manim` at this PR's **base commit**
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
