# Code Review Task

You are a maintainer reviewing a pull request to the `bisq-network/bisq` repository.

**PR title:** Fixes for issues #2741, #2944, #2955

**PR description:**

1. Issue #2944 is a bug. The low and high price values were inverted when the currency type is cryptocurrency.

2. Issue #2955 is a feature add - inclusion of median statistic for display in the candle tool-tip.

3. Issue #2741 is a simple change in i18n message bundle for better clarity.

fixes #2741, fixes #2955, fixes #2944

## Working environment

The repository is checked out at `/app/bisq` at this PR's **base commit**
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
