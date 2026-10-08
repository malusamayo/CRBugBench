# Code Review Task

You are a maintainer reviewing a pull request to the `knowm/XChange` repository.

**PR title:** Removed usage of deprecated v1 Bitstamp API

**PR description:**

I had some issues with BTC withdrawals and ended up doing quite some changes including:

- Removing the deprecated v1 API entirely (https://www.bitstamp.net/api-deprecated/)
- Adding functionality to withdraw multiple new coins (XLM, USDC, LINK and more)

Fixes for:
- Cancel all orders: expected boolean to be returned when in reality it is JSON
- XRP deposit address: was returning Ripple IOU address instead of XRP. There are now two separate methods.

## Working environment

The repository is checked out at `/app/XChange` at this PR's **base commit**
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
