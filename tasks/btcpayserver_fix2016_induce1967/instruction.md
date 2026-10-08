# Code Review Task

You are a maintainer reviewing a pull request to the `btcpayserver/btcpayserver` repository.

**PR title:** Payment redesign (#1967)

**PR description / commit message:**

Payment redesign (#1967)

* Payment redesign

Guess who's back!

This reverts commit 4174fa648d994e098d8555bca0a5b3a255541cb5.

* Refactor PullPayment state string

Compatible with this one: https://github.com/btcpayserver/btcpayserver/pull/1834/files#diff-a9136096252382b110b9a7ac7747b95aR41

* Use unified copy to clipboard function

* Refactor status text class to helper function

## Working environment

The repository is checked out at `/app/btcpayserver` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
