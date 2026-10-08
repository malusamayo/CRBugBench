# Code Review Task

You are a maintainer reviewing a pull request to the `btcpayserver/btcpayserver` repository.

**PR title:** Abstracted cloud storage - Amazon/Google/Azure/Local (#708)

**PR description / commit message:**

Abstracted cloud storage - Amazon/Google/Azure/Local (#708)

* wip

* add in storage system

* ui fixes

* fix settings ui

* Add Files Crud UI

* add titles

* link files to users

* add migration

* set blob to public

* remove base 64 read code

* fix file query model init

* move view model to own file

* fix local root path

* use datadir for local storage

* move to services

* add direct file url

* try fix tests

* remove magic string

* remove other magic strings

* show error message on unsupported provider

* fix asp net version

* redirect to storage settings if provider is not supported

* start writing tests

* fix tests

* fix test again

* add some more to the tests

* more tests

* try making local provider work on tests

* fix formfile

* fix small issue with returning deleted file

* check if returned data is null for deleted file

* validate azure Container name

* more state fixes

* change azure test trait

* add tmp file url generator

* fix tests

* small clean

* disable amazon and  google


comment out unused code for now


comment out google/amazon

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
