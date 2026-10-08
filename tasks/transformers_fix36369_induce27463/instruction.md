# Code Review Task

You are a maintainer reviewing a pull request to the `huggingface/transformers` repository.

**PR title:** Add segmentation map processing to SAM Image Processor (#27463)

**PR description / commit message:**

Add segmentation map processing to SAM Image Processor (#27463)

* add segmentation map processing to sam image processor

* fixup

* add tests

* reshaped_input_size is shape before padding

* update tests for size/shape outputs

* fixup

* add code snippet to docs

* Update docs/source/en/model_doc/sam.md

Co-authored-by: amyeroberts <22614925+amyeroberts@users.noreply.github.com>

* Add missing backticks

* add `segmentation_maps` as arg for SamProcessor.__call__()

---------

Co-authored-by: amyeroberts <22614925+amyeroberts@users.noreply.github.com>

## Working environment

The repository is checked out at `/app/transformers` at this PR's **base commit**
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
