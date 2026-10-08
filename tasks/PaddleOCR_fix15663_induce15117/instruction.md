# Code Review Task

You are a maintainer reviewing a pull request to the `PaddlePaddle/PaddleOCR` repository.

**PR title:** Add deployment docs and enhance CLI (#15117)

**PR description / commit message:**

Add deployment docs and enhance CLI (#15117)

* Add serving and hpi docs

* Optimize CLI logging info

* Update interface

* Add on-device deployment and onnx model conversion docs

* Enhance CLI

* _gen->_iter

* Fix CLI help message

* Update table_recognition_v2 and PP-StructureV3 interfaces

* Update installation doc

* Update interface

* Update interface

* Add logging doc

* Update default values

---------

Co-authored-by: cuicheng01 <45199522+cuicheng01@users.noreply.github.com>

## Working environment

The repository is checked out at `/app/PaddleOCR` at this PR's **base commit**
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
