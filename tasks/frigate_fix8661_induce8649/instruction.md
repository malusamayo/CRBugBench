# Code Review Task

You are a maintainer reviewing a pull request to the `blakeblackshear/frigate` repository.

**PR title:** Include libraries and .rknn models for other Rockchip SoCs (#8649)

**PR description / commit message:**

Include libraries and .rknn models for other Rockchip SoCs (#8649)

* support for other yolov models and config checks

* apply code formatting

* Information about core mask and inference speed

* update rknn postprocess and remove params

* update model selection

* Apply suggestions from code review

Co-authored-by: Nicolas Mowen <nickmowen213@gmail.com>

* support rknn on all socs

* apply changes from review and fix post process bug

* apply code formatting

* update tip in object_detectors docs

---------

Co-authored-by: Nicolas Mowen <nickmowen213@gmail.com>

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
