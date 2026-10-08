# Code Review Task

You are a maintainer reviewing a pull request to the `blakeblackshear/frigate` repository.

**PR title:** Rewrite restream (#5106)

**PR description / commit message:**

Rewrite restream (#5106)

* Tear out restream config

* Rework birdseye restream

* Create go2rtc config handler

* Fix bug

* Write start script

* Rework style

* Fix python run syntax

* Output as json instead of yaml

* Put old live config back and fix birdseye references

* Fix camera webUI

* Add frigate env var subsitutions

* Fix webui checks

* Check keys

* Remove unused prest

* Fix tests

* Update restream docs

* Update restream docs

* Update live docs

* Update camera specific recommendation

* Update more docs

* add links for the docs

Co-authored-by: Felipe Santos <felipecassiors@gmail.com>

* Update note about supported audio codecs

* Move restream to go2rtc

* Docs fixes

* Add verification of stream name

* Ensure that webUI uses camera name

* Update docs to reflect new live stream name

* Fix check

* Formatting

* Remove audio from detect

Co-authored-by: Felipe Santos <felipecassiors@gmail.com>

* Fix docs

* Don't handle env variable substitution

* Add go2rtc version

* Clarify docs

Co-authored-by: Felipe Santos <felipecassiors@gmail.com>

## Working environment

The repository is checked out at `/app/frigate` at this PR's **base commit**
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
