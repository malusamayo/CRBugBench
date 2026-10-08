# Code Review Task

You are a maintainer reviewing a pull request to the `SeleniumHQ/selenium` repository.

**PR title:** [rust] Automated Edge management (#11681 and #11683) (#12835)

**PR description / commit message:**

[rust] Automated Edge management (#11681 and #11683) (#12835)

* [rust] Automated Edge management (macOS) (#11681)

* [rust] Check also unstable versions for Edge management

* [rust] Include logic to check fixed versions of Edge

* [rust] Get browser url again if empty

* [rust] Include logic for stable label

* [rust] Automated Edge management (Linux) (#11681 and #11683)

* [rust] Fix paths used to extract edge

* [rust] Clean extract label and fix searched version

* [rust] Refactor logic for downloading browsers in a common function

* [rust] Install Edge in Windows through the MSI installer

* [rust] Check admin permissions in Windows before downloading MSI installer

* [rust] Use browser version in functions for requesting online repos

* [rust] Refactor common logic when unavailable download or discovery

* [rust] Fix condition checking Firefox nightly in mac

* [rust] Update cargo bazel lock file

* [rust] Separate function to ensure empty parent path before moving files

---------

Co-authored-by: titusfortner <titus.fortner@gmail.com>
Co-authored-by: Titus Fortner <titusfortner@users.noreply.github.com>

## Working environment

The repository is checked out at `/app/selenium` at this PR's **base commit**
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
