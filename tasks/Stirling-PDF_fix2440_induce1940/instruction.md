# Code Review Task

You are a maintainer reviewing a pull request to the `Stirling-Tools/Stirling-PDF` repository.

**PR title:** Home page improvements (#1940)

**PR description / commit message:**

Home page improvements (#1940)

* Add feautre group header fragment for homepage.

* Add feature group headers to feature groups.

* Style feature groups.

* Add collapsing/expanding functionality as well as a favorites section.

* Cards are now sorted in the order of update link > favorite > alphabetical on the homepage.

* Decrease space between section title and cards.

* Add filtering buttons and view options to homepage.

* Hide list view button in preparation for release.

---------

Co-authored-by: FiratUsta <ahmetfiratusta@gmail.com>

## Working environment

The repository is checked out at `/app/Stirling-PDF` at this PR's **base commit**
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
