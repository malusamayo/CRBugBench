# Code Review Task

You are a maintainer reviewing a pull request to the `elastic/elasticsearch` repository.

**PR title:** SQL: Improve ROUND and TRUNCATE to better manage Long values and big Doubles

**PR description:**

Reimplement TRUNCATE and ROUND functions to fix the following problems:

- preserve input type (eg. `ROUND(Long)` returns a `Long`, `ROUND(Double)` returns `Double`) 
- avoid loss of precision (eg. Long->Double->Long) and number overflows (a big Double->Long->Double) in the calculation algorithm 
- improve the performance on common cases (eg. `ROUND(N, 0)`, `ROUND(N, 2)` ...)

Fixes #49391
Fixes #85105

## Working environment

The repository is checked out at `/app/elasticsearch` at this PR's **base commit**
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
