# Code Review Task

You are a maintainer reviewing a pull request to the `ManimCommunity/manim` repository.

**PR title:** Added ``media_embed`` config option to control whether media in Jupyter notebooks is embedded (#2442)

**PR description / commit message:**

Added ``media_embed`` config option to control whether media in Jupyter notebooks is embedded (#2442)

* feat: Added --embed option to %%manim ManimMagic.

* feat: Change to --embed and also embed Images

* Update manim/utils/ipython_magic.py

Co-authored-by: Benjamin Hackl <devel@benjamin-hackl.at>

* Initial attempt to make media_embed a general config option

* fixed issues raised in code review

* [pre-commit.ci] auto fixes from pre-commit.com hooks

for more information, see https://pre-commit.ci

* remove unused import

* actually remove unused import

Co-authored-by: Benjamin Hackl <devel@benjamin-hackl.at>
Co-authored-by: Michael McNeil Forbes <michael.forbes+python@gmail.com>
Co-authored-by: pre-commit-ci[bot] <66853113+pre-commit-ci[bot]@users.noreply.github.com>

## Working environment

The repository is checked out at `/app/manim` at this PR's **base commit**
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
