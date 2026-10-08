# Code Review Task

You are a maintainer reviewing a pull request to the `alacritty/alacritty` repository.

**PR title:** Add configuration file imports

**PR description:**

This adds the ability for users to have multiple configuration files
which all inherit from each other.

The order of imports is chronological, branching out to the deepest
children first and overriding every field with that of the configuration
files that are loaded at a later point in time.

Live config reload watches the directories of all configuration files,
allowing edits in any of them to update Alacritty immediately. While the
imports are live reloaded, a new configuration file watcher will only be
spawned once Alacritty is restarted.

Since this might cause loops which would be very difficult to detect, a
maximum depth is set to limit the recursion possible with nested
configuration files.

Fixes #779.

## Working environment

The repository is checked out at `/app/alacritty` at this PR's **base commit**
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
