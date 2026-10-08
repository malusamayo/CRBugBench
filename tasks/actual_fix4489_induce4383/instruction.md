# Code Review Task

You are a maintainer reviewing a pull request to the `actualbudget/actual` repository.

**PR title:** Fix currencyToAmount incorrectly converting input (#4383)

**PR description / commit message:**

Fix currencyToAmount incorrectly converting input (#4383)

* fix: ensure currencyToAmount works regardless of the configured number format

* chore: linting

* docs: add release note

* test: ensure correct amount is entered for debit when adding split transactions

* chore: rename variable thousandsSep to thousandsSeparator

Co-authored-by: Joel Jeremy Marquez <joeljeremy.marquez@gmail.com>

* chore: rename variable decimalSep to decimalSeparator

Co-authored-by: Joel Jeremy Marquez <joeljeremy.marquez@gmail.com>

* chore: rename decimalSep and thousandsSep variables to decimalSeparator and thousandsSeparator

---------

Co-authored-by: Joel Jeremy Marquez <joeljeremy.marquez@gmail.com>

## Working environment

The repository is checked out at `/app/actual` at this PR's **base commit**
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
