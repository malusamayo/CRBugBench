# Code Review Task

You are a maintainer reviewing a pull request to the `QuantConnect/Lean` repository.

**PR title:** Feature Daily/Hourly Options Support (#6017)

**PR description / commit message:**

Feature Daily/Hourly Options Support (#6017)

* Create generic writing for LeanDataWriter, + notes on todos

* Make Options Daily/Hourly data store by year

* Refactor Generic Write

* Permit hour and daily resolutions for options

* Refactor writer to merge when needed with other files

* Cleanup redundancies, run write tasks in parallel

* Make needed classes/vars available

* Update tests to reflect new naming convention for daily hourly options data

* Add Byte[] overloads for ZipData functions in compression

* Implemented Store() for ZipDataCacheProvider

* Have LeanDataWriter use a DataCacheProvider

* ZipDataCacheProvider cleanup

* ZipDataCacheProvider tweaks, doesn't support storing non-zips

* Test adjustments

* Update LeanDataWriter to use Write instead of SaveDailyHourly/SaveMinuteSecond

* Implement tests to verify DownloadAndSave behavior

* Nit cleanup on DownloadAndSave tests

* Fix for options daily/hourly underlying equity subscription read

* Add daily/hourly options data and regressions

* Add missing open interest for hourly

* Fix writing of OpenInterest Daily/Hourly data

* Update data

* Fix Date typo in regression

* Use daily algorithm to test delisting

* Revisions part 1

* Expand test for DataCacheProviders; refactor DiskDataCacheProvider

* nit - test adjustments

* ZipDataCacheProvider test setup refactor

* Adjust multithreaded read/write test; fixes for ZipDataCacheProvider

* Move DiskDataCacheProvider to its own file and add write test

* Remove _appendToZips; always overwrite entry or create zip

* Add mapping regression for daily options

* nit - add license to regression

* Fix Tick write case where more than one data point for a DateTime

* Fix data issue

* Address review

* Tweaks for tests

* Stop Store() early if no entry name is given

## Working environment

The repository is checked out at `/app/Lean` at this PR's **base commit**
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
