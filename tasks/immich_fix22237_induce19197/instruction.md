# Code Review Task

You are a maintainer reviewing a pull request to the `immich-app/immich` repository.

**PR title:** feat(mobile): sqlite timeline (#19197)

**PR description / commit message:**

feat(mobile): sqlite timeline (#19197)

* wip: timeline

* more segment extensions

* added scrubber

* refactor: timeline state

* more refactors

* fix scrubber segments

* added remote thumb & thumbhash provider

* feat: merged view

* scrub / merged asset fixes

* rename stuff & add tile indicators

* fix local album timeline query

* ignore hidden assets during sync

* ignore recovered assets during sync

* old scrubber

* add video indicator

* handle groupBy

* handle partner inTimeline

* show duration

* reduce widget nesting in thumb tile

* merge main

* chore: extend cacheExtent

* ignore touch events on scrub label when not visible

* scrub label ignore events and hide immediately

* auto reload on sync

* refactor image providers

* throttle db updates

---------

Co-authored-by: shenlong-tanwen <139912620+shalong-tanwen@users.noreply.github.com>
Co-authored-by: Alex Tran <alex.tran1502@gmail.com>

## Working environment

The repository is checked out at `/app/immich` at this PR's **base commit**
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
