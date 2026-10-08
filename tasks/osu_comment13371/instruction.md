# Code Review Task

You are a maintainer reviewing a pull request to the `ppy/osu` repository.

**PR title:** Clean up previous sample immediately on skin source change to avoid `Play` after disposal

**PR description:**

This seems to be the simplest way to avoid calls to `Play` after the underlying sample may have been disposed. As per the issue thread, a local workaround is acceptable here.

Closes #13223, in theory (hard one to repro in the first place).

## Working environment

The repository is checked out at `/app/osu` at this PR's **base commit**
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
