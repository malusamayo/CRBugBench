# Code Review Task

You are a maintainer reviewing a pull request to the `mitmproxy/mitmproxy` repository.

**PR title:** Add block_list Option to set HTTP status for blocked flows/urls (#4516)

**PR description / commit message:**

Add block_list Option to set HTTP status for blocked flows/urls (#4516)

* Add block_list Option which returns a set HTTP status for a blocked flow filter:URL

* Add changelog entry

* Add blocklist to default AddOns

* Add Nginx 444 status code to list, so it is available for validation

* Add overview of blocklists

* Add allow-only, and more tests

* Fix mypy tox issue

* Finish test coverage with test for invalid filter

* Add PR feedback

* Fix type/scope error

* Fix stray blank line

* Delete concepts-blocklist.md

* Feature in overview

* Add flag to metadata for blocklisted flows.

* minor improvements

Co-authored-by: Maximilian Hils <git@maximilianhils.com>

## Working environment

The repository is checked out at `/app/mitmproxy` at this PR's **base commit**
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
