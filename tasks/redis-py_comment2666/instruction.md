# Code Review Task

You are a maintainer reviewing a pull request to the `redis/redis-py` repository.

**PR title:** Fixing cancelled async futures

**PR description:**

The following pull request contains changes to Async cancelling.  Specifically, all cases where a command is sent to redis, via execute_command (and friends), and now wrapped with a shield. This builds on the helpful proxy provided in #2665.

This change covers the following usage patterns.

* Async
* Async pipeline
* Async pubsub
* Async sentinel
* Async cluster
* Async cluster pipelines

Reproducible tests currently exist for async, async pipeline, and async cluster. But note - the async cluster pipeline seems at best incorrect.

Feedback and changes are very much welcomed. Bonus points for assistance with testing,

## Working environment

The repository is checked out at `/app/redis-py` at this PR's **base commit**
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
