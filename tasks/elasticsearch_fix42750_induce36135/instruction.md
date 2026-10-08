# Code Review Task

You are a maintainer reviewing a pull request to the `elastic/elasticsearch` repository.

**PR title:** Add intervals query (#36135)

**PR description / commit message:**

Add intervals query (#36135)

* Add IntervalQueryBuilder with support for match and combine intervals

* Add relative intervals

* feedback

* YAML test - broekn

* yaml test; begin to add block source

* Add block; make disjunction its own source

* WIP

* Extract IntervalBuilder and add tests for it

* Fix eq/hashcode in Disjunction

* New yaml test

* checkstyle

* license headers

* test fix

* YAML format

* YAML formatting again

* yaml tests; javadoc

* Add OR test -> requires fix from LUCENE-8586

* Add docs

* Re-do API

* Clint's API

* Delete bash script

* doc fixes

* imports

* docs

* test fix

* feedback

* comma

* docs fixes

* Tidy up doc references to old  rule

## Working environment

The repository is checked out at `/app/elasticsearch` at this PR's **base commit**
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
