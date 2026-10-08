# Code Review Task

You are a maintainer reviewing a pull request to the `netbox-community/netbox` repository.

**PR title:** Closes: #9047 - Add Provider Accounts (#12057)

**PR description / commit message:**

Closes: #9047 - Add Provider Accounts (#12057)

* #9047 - ProviderAccount

* #9047 - Move to new selector types

* #9047 - Re-introduce provider FK to Circuit model

* #9047 - Fix broken tests

* Misc cleanup

* Revert errant change

* Fix tests

* Update circuit filter form

---------

Co-authored-by: jeremystretch <jstretch@netboxlabs.com>

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
