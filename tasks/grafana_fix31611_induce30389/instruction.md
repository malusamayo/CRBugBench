# Code Review Task

You are a maintainer reviewing a pull request to the `grafana/grafana` repository.

**PR title:** PanelOptions: Refactoring applying panel and field options out of PanelModel and add property clean up for properties not in field config registry  (#30389)

**PR description / commit message:**

PanelOptions: Refactoring applying panel and field options out of PanelModel and add property clean up for properties not in field config registry  (#30389)

* PanelOptions: Refactoring on applying panel and field options from PanelModel

* Progress

* Filtering out props

* downgraded prettier

* Fixes

* Initial simple remember and restore for custom and overrides

* clearing custom options and overrides and restoring works

* actually use the function

* Added type for options cache

* minor fix

* Updated with new prettier

* Added old field config to panel type change handler

* Update public/app/features/dashboard/state/getPanelOptionsWithDefaults.test.ts

Co-authored-by: Dominik Prokop <dominik.prokop@grafana.com>

Co-authored-by: Dominik Prokop <dominik.prokop@grafana.com>

## Working environment

The repository is checked out at `/app/grafana` at this PR's **base commit**
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
