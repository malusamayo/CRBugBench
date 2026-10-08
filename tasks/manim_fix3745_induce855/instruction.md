# Code Review Task

You are a maintainer reviewing a pull request to the `ManimCommunity/manim` repository.

**PR title:** Markup text (#855)

**PR description / commit message:**

Markup text (#855)

* Minor changes: double line + typos in Text and CairoText

* Add MarkupText class

* Accidentally ran BLACK on wrong file...

* Clean up import, extent SVGMobject instead of Text

* Added offset attribute to workaround ligature problems

* Disable all ligatures when disable_ligatures=True

* BLACK

* Improvements, docs, examples

- individual offset for start and end of partial colorizing / gradients in case there are ligatures inside the string that has to be colorized
- deal with HTML entities in string
- documentation of supported tags
- full set of examples

* removing disable_ligatures from example b/c of failing doc build

* take disable_ligature into account in hash

* doc cleanup + change text2hash to take into account disable_ligatures

* Docs and examples cleanup

* Changelog + bugfix for multi-line strings

* add one more example + small fix

* Remove entries in changelog

will put them in the wiki

* Accept colors as hex triples; typing as per review

* cleanup: gen_chars should not be needed anymore

* Cleanup: PangoUtils class with static methods

* Add color to ligature example

* Small change, mainly to trigger checks again

* Typings, Cleanup

Co-authored-by: Naveen M K <naveen@syrusdark.website>

* Remove warning; it is no longer accurate

* Move remove_last_M to PangoUtils class & make static

* Remove warnings about transofmration

* Doc cleanup

Co-authored-by: Benjamin Hackl <devel@benjamin-hackl.at>

* Clean up docstrings

Co-authored-by: Benjamin Hackl <devel@benjamin-hackl.at>

* Black

Co-authored-by: Naveen M K <naveen@syrusdark.website>
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
