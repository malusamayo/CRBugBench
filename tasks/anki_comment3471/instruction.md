# Code Review Task

You are a maintainer reviewing a pull request to the `ankitects/anki` repository.

**PR title:** Add card position column and always show position in card info

**PR description:**

Implements #3336

- New position column that displays the original position of the card, supported with cards and notes sortable
![image](https://github.com/user-attachments/assets/826425f6-26df-4eea-ad94-8fe971087013)
- Original position now always show in card info
![image](https://github.com/user-attachments/assets/740556f9-8831-42ae-911a-ba72373e6061)

## Working environment

The repository is checked out at `/app/anki` at this PR's **base commit**
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
