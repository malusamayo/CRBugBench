# Code Review Task

You are a maintainer reviewing a pull request to the `bevyengine/bevy` repository.

**PR title:** Fix  get_asset_paths not properly deleting empty folders (& recursive async functions)

**PR description:**

# Objective

 get_asset_paths tries to check whether a folder is empty, and if so delete it. However rather than checking whether any subfolder contains files it checks whether _all_ subfolders have files.

Also cleanup various BoxedFutures in async recursive functions like these, rust 1.77 now allows recursive async functions (albeit still by boxing), hurray! This is a followup to #12550 (sorta). More BoxedFuture stuff can be removed now that rust 1.77 is out, which can use async recursive functions! This is mainly just cleaner code wise - the recursion still boxes the future so not much to win there.

PR is mainly whitespace changes so do disable whitespace diffs for easier review.

## Working environment

The repository is checked out at `/app/bevy` at this PR's **base commit**
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
