# Code Review Task

You are a maintainer reviewing a pull request to the `bisq-network/bisq` repository.

**PR title:** Fix issues with missing persistence for trade state

**PR description:**

There are some bug reports which suggest that the persistence at shutdown is not working reliable (hard kill, crash,...).
We reduce the persistence interval radically to ensure important data is written immediately (200 ms delay).
Further the `requestPersistence` has been missing in most trade tasks. I guess that happened when merging the large refactoring projects (trade protocol, persistence). If shutdown routine gets executed it did not had any effect as we wrote then the trade state, but if that was missing we might miss important trade state/data changes.
 
Fixes https://github.com/bisq-network/bisq/issues/4806
Fixes https://github.com/bisq-network/bisq/issues/4762

## Working environment

The repository is checked out at `/app/bisq` at this PR's **base commit**
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
