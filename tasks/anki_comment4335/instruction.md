# Code Review Task

You are a maintainer reviewing a pull request to the `ankitects/anki` repository.

**PR title:** Speed up update_memory_state by batching FSRS memory state calculation

**PR description:**

Break down `update_memory_state` into three cases:
1. Clear FSRS data for cards
2. Update memory state for cards without items
3. Update memory state for cards with items

Use `fsrs.memory_state_batch` over `card.set_memory_state` when handling case 3 for performance gains.

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
