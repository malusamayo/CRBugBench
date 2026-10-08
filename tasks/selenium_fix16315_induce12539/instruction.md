# Code Review Task

You are a maintainer reviewing a pull request to the `SeleniumHQ/selenium` repository.

**PR title:** [java] Copy SM binary to cache folder and use it from there (#11359) (#12539)

**PR description / commit message:**

[java] Copy SM binary to cache folder and use it from there (#11359) (#12539)

* [java] Copy SM binary to cache folder and use it from there

* [java] Read cache path from the config file and as env

* [java] Read cache-path as env only

* [java] Use BuildInfo class to get current Selenium version

* [java] if cache path is not writable, SM will be extracted to a temporal folder

* [java] Include shutdown hook again to delete binary when stored in tmp folder

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
