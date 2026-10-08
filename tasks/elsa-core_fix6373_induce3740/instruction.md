# Code Review Task

You are a maintainer reviewing a pull request to the `elsa-workflows/elsa-core` repository.

**PR title:** Refactor store APIs (#3740)

**PR description / commit message:**

Refactor store APIs (#3740)

* Add array support for input/output arguments

* Add alias support for nullable types

* Refactor workflow definition store API

* Fix array and ui hint setting of input/output definition

* Refactor workflow instance store API

* Add XML comments

* Refactor trigger and bookmark store API

## Working environment

The repository is checked out at `/app/elsa-core` at this PR's **base commit**
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
