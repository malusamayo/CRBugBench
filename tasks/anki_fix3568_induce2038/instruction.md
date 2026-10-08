# Code Review Task

You are a maintainer reviewing a pull request to the `ankitects/anki` repository.

**PR title:** Some import/export features and fixes (#2038)

**PR description / commit message:**

Some import/export features and fixes (#2038)

* Keep filtered decks when importing apkg

If all original decks exist and scheduling is included.

* Create missing decks from csv

* Export original decks if with_scheduling

* Also remap original deck ids on import

* Update imported filtered decks

* Fix meta column being mapped to tags

* Fix ids in csv deck and notetype columns

Note: This implies names which parse to an i64 will be seen as ids,
likely resulting in the intended deck/notetype not being found.

* Check for scheduling with revlog and deck configs

Might help with cases in which scheduling was included, but all cards
are new. In such a case, filtered deck should not be converted.

* Fix duplicate with same GUID being created

* Remove redundant `distinct`s from sql query

* Match notes by _either_ guid _or_ first field

* Refactor to emphasise GUID/first field distinction

* Export default deck and config if with scheduling

* Fix default deck being exported if it's a parent

## Working environment

The repository is checked out at `/app/anki` at this PR's **base commit**
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
