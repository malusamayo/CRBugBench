# Code Review Task

You are a maintainer reviewing a pull request to the `JabRef/jabref` repository.

**PR title:** Show information about the journal (#10015)

**PR description / commit message:**

Show information about the journal (#10015)

* add script for getting journal data

* reduce json size

* add journal info UI button & gui components

* add placeholder charts

* add journal information fetcher

* run fetch as background task

* fetch data using entry issn

* add journal information preferences

* make journal info service opt-in

* add fields to journal info view

* update fetcher to use jabref api

* parse remaining fields from json response

* handle journal info fetching errors

* add charts to journal info view

* add fetcher tests

* Update url

* update translation keys, add script comments

* use issn parser

* check error in api response

* add enablement states for online service

* add journal info button to ISSN editor

* update chart titles and error msg

* use enum string in preferences

* add support for journal name in fetcher

* update journal info ui

* fix localization tests

* add changelog entry

* Remove script to get journal data

* Change API url to production

* change log pattern, make popover detachable

* show info only on fetch failure

* update tests

---------

Co-authored-by: Tobias Diez <code@tobiasdiez.com>
Co-authored-by: Oliver Kopp <kopp.dev@gmail.com>

## Working environment

The repository is checked out at `/app/jabref` at this PR's **base commit**
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
