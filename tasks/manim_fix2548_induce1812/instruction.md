# Code Review Task

You are a maintainer reviewing a pull request to the `ManimCommunity/manim` repository.

**PR title:** Implement logarithmic scaling for :class:`~.NumberLine`/:class:`~.Axes`  (#1812)

**PR description / commit message:**

Implement logarithmic scaling for :class:`~.NumberLine`/:class:`~.Axes`  (#1812)

* scaling, add differnt scalings, adjust to use x_range, adjust line movement to make it applicable

* kind of ugly solution to make coords_to_point do less pointless calculations

* refactoring and add_labels

* numberplane fix

* make functions scaling-compatible

* decimal_number scaling for the units

* docs for axes

* minor docs changes

* Pre-PR cleaning

* missing bug

* typo

Co-authored-by: Darylgolden <darylgolden@gmail.com>

* [pre-commit.ci] auto fixes from pre-commit.com hooks

for more information, see https://pre-commit.ci

* remove redundant add_labels

* move import out of TYPE_CHECKING

* add scale to init.py

* missing underscores

* fix broken test

* fix numberplane line generation for log

* add scale.py to the docs and replace dict outout for custom_labels with a list

* add explanation and default for exclude_origin_tick

* custom labels using .add_coordinates()

* add test, valueerror warning and docs

* add .npz file and adjust docs

* add numberplane log test

* quick docs for ParametricFunction

* add extra condition because None becomes LinearBase too

* flip x and y

* add exclude_origin_tick business for z_axis

* adjust threed test

* improve docs for number line.

* add more docs

* more docs for number line

* pre-merge docs improvements

* fix return types

* attempt to fix weird formatting

* fix questionable doc choice

* l1 != li

* correct the index for 6

* correct the index for 6

Co-authored-by: Darylgolden <darylgolden@gmail.com>
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
