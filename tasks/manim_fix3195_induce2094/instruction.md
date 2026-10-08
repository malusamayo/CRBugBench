# Code Review Task

You are a maintainer reviewing a pull request to the `ManimCommunity/manim` repository.

**PR title:** Implemented :class:`~.ImplicitFunction` and :meth:`.CoordinateSystem.get_implicit_curve` for plotting implicit curves (#2094)

**PR description / commit message:**

Implemented :class:`~.ImplicitFunction` and :meth:`.CoordinateSystem.get_implicit_curve` for plotting implicit curves (#2094)

* dependencies

* ImplicitFunction

* coord sys typo

* implicit graph

* tests

* lower max quads

* Update ImplicitFunction.npz

* corrections

* renamed graph to curve

* use_smoothing

* return type

* depth vs quads docs

* fix docstrings

* added more clarification

* updated note admonition

* [pre-commit.ci] auto fixes from pre-commit.com hooks

for more information, see https://pre-commit.ci

* Apply suggestions from code review

Co-authored-by: Benjamin Hackl <devel@benjamin-hackl.at>

* Add keywords

* updated isosurfaces import

* unnecessary args as kwargs

* unnecessary args as kwargs

* Revert "updated isosurfaces import"

This reverts commit 16ac042a415d4f700e831b4f6da19990aae64165.

* small fix

* Update poetry.lock

Co-authored-by: pre-commit-ci[bot] <66853113+pre-commit-ci[bot]@users.noreply.github.com>
Co-authored-by: Benjamin Hackl <devel@benjamin-hackl.at>

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
