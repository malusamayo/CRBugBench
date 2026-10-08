# Code Review Task

You are a maintainer reviewing a pull request to the `uutils/coreutils` repository.

**PR title:** sort: implement --debug

**PR description:**

This adds a --debug flag, which, when activated, will draw lines below
the characters that are actually used for comparisons.

This is not a complete implementation of --debug. It should, quoting the man page
for GNU sort: "annotate the part of the line used to sort, and warn
about questionable usage to stderr". Warning about "questionable usage"
is not part of this patch.

This change required some adjustments to be able to get the range that
is actually used for comparisons. Most notably, general numeric comparisons
were rewritten, fixing some bugs along the lines.

Testing is mostly done by adding fixtures for the expected debug output of
existing tests.

## Working environment

The repository is checked out at `/app/coreutils` at this PR's **base commit**
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
