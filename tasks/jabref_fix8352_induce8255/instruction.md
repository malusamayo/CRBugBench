# Code Review Task

You are a maintainer reviewing a pull request to the `JabRef/jabref` repository.

**PR title:** Clicking a DOI link in the preview pane no longer crashes (#8255)

**PR description / commit message:**

Clicking a DOI link in the preview pane no longer crashes (#8255)

* Fixed DOI link causing exception; now opens in browser

* Added to changelog

* Fixed checkstyle issue

* Removed awt package references

* Browser opens with JabrefDesktop

* Switched to using LOGGER

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
