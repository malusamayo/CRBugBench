# Code Review Task

You are a maintainer reviewing a pull request to the `alacritty/alacritty` repository.

**PR title:** Fix signal cleanup polling

**PR description:**

This fixes two minor issues introduced in 96f488d.

The main problem was the fact that the I/O event polling on Unix was only started when the IPC socket feature is enabled. While generally this is the main reason why we need to shutdown cleanly, there's no reason why we wouldn't *always* do so. This ensures the log file is always cleaned up properly on Unix.

Another minor issue with the signal polling was that the pipe was registered for reading, but never drained when it was ready to be read from. While this would mean we're already in the process of shutting down anyway, this would redundantly send about 1000 shutdown requests, rather than just one.

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
