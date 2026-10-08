# Code Review Task

You are a maintainer reviewing a pull request to the `JabRef/jabref` repository.

**PR title:** Entry editor goes JavaFX (#2754)

**PR description / commit message:**

Entry editor goes JavaFX (#2754)

* Initial convert to JavaFX

* Revert to default look

* Rename

* Create custom editor control as test

* Switch to JavaFX version of editor

* Add preliminary version of DOI editor

* Implement DOI editor in JavaFX

* Bind entry editor field values bidirectional to BibEntry fields

* Code cleanup / add todos

* Remove unused import

* Make DOI editor generic and use for other identifiers

* Fix tests

## Working environment

The repository is checked out at `/app/jabref` at this PR's **base commit**
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
