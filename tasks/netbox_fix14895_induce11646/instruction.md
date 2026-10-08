# Code Review Task

You are a maintainer reviewing a pull request to the `netbox-community/netbox` repository.

**PR title:** Closes #11558: Add support for remote data sources (#11646)

**PR description / commit message:**

Closes #11558: Add support for remote data sources (#11646)

* WIP

* WIP

* Add git sync

* Fix file hashing

* Add last_synced to DataSource

* Build out UI & API resources

* Add status field to DataSource

* Add UI control to sync data source

* Add API endpoint to sync data sources

* Fix display of DataSource job results

* DataSource password should be write-only

* General cleanup

* Add data file UI view

* Punt on HTTP, FTP support for now

* Add DataSource URL validation

* Add HTTP proxy support to git fetcher

* Add management command to sync data sources

* DataFile REST API endpoints should be read-only

* Refactor fetch methods into backend classes

* Replace auth & git branch fields with general-purpose parameters

* Fix last_synced time

* Render discrete form fields for backend parameters

* Enable dynamic edit form for DataSource

* Register DataBackend classes in application registry

* Add search indexers for DataSource, DataFile

* Add single & bulk delete views for DataFile

* Add model documentation

* Convert DataSource to a primary model

* Introduce pre_sync & post_sync signals

* Clean up migrations

* Rename url to source_url

* Clean up filtersets

* Add API & filterset tests

* Add view tests

* Add initSelect() to HTMX refresh handler

* Render DataSourceForm fieldsets dynamically

* Update compiled static resources

## Working environment

The repository is checked out at `/app/netbox` at this PR's **base commit**
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
