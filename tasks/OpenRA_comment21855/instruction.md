# Code Review Task

You are a maintainer reviewing a pull request to the `OpenRA/OpenRA` repository.

**PR title:** Add Generate Map tab to the lobby map chooser.

**PR description:**

This PR introduces a third classification of map (together with local and remote): `MapClassification.Generated`, which is constructed at runtime by passing an opaque yaml blob to a mod-defined map generation trait.

~~The lobby random map generator UI is split into its own followup PR, so this includes a simple testcase that overrides the "Change Map" button to select a random map with default settings. Note that the default settings in RA fail for at least one of the tilesets (probably Interior?), so it may take a couple of button presses for it to work (and/or just test in TD).~~

Depends on ~~#21849~~, ~~#21850~~, ~~#21859~~, ~~#21860~~, ~~#21861~~, ~~#21868~~, ~~#21869~~, ~~#21870~~, ~~#21871~~, ~~#21876~~, ~~#21877~~.

Strongly recommend reviewing by commit.

## Working environment

The repository is checked out at `/app/OpenRA` at this PR's **base commit**
(the state before this PR), and the proposed change is present two ways:

- applied as **uncommitted modifications** to the working tree (run `git diff`
  to see it, or use a review tool that inspects the local git diff), and
- saved as a unified diff at `/app/pr_to_review.diff`.

Use `git log` and `git show HEAD:<path>` (HEAD is the base commit) for
surrounding history, call sites, and conventions.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
