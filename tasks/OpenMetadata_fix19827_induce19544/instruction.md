# Code Review Task

You are a maintainer reviewing a pull request to the `open-metadata/OpenMetadata` repository.

**PR title:** Fix 19499: feat(apps): add app config in run record (#19544)

**PR description / commit message:**

Fix 19499: feat(apps): add app config in run record (#19544)

* feat(apps): add app config in run record

- changed returned schema type of "status" to "AppRunRecord"!
- added a "config" field in the app record
- added a "pending" stage so that "external" app status can be mapped ti internal app status

* added note about schema compatiblity

* added app config for external apps

* show config for every app run

* add tests

* revert open change for now

* Revert "revert open change for now"

This reverts commit e1492a5c92d1967b3d47230a25df4c2c3d399de2.

* update dependency

---------

Co-authored-by: karanh37 <karanh37@gmail.com>
Co-authored-by: Karan Hotchandani <33024356+karanh37@users.noreply.github.com>

## Working environment

The repository is checked out at `/app/OpenMetadata` at this PR's **base commit**
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
