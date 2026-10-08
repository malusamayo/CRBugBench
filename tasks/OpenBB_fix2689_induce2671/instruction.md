# Code Review Task

You are a maintainer reviewing a pull request to the `OpenBB-finance/OpenBB` repository.

**PR title:** Bug/2583 (#2671)

**PR description / commit message:**

Bug/2583 (#2671)

* #2583 [CT] Add and use denomination helper

* #2583 [CT] Fix Yahoo Finance denomination

* #2583 [CT] Fix typings for dict

* #2583 [CT] Add YF model get financials tests

* #2583 [CT] Fix stubbed currency

* #2583 [CT] Add test coverage for denomination helpers

* #2583 [CT] Fix YF view not exporting raw data

Co-authored-by: DidierRLopes <dro.lopes@campus.fct.unl.pt>
Co-authored-by: Colin Delahunty <72827203+colin99d@users.noreply.github.com>

## Working environment

The repository is checked out at `/app/OpenBB` at this PR's **base commit**
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
