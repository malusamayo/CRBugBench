# Code Review Task

You are a maintainer reviewing a pull request to the `duplicati/duplicati` repository.

**PR title:** Bugfix/Remote synchronization tool reinstantiate backend

**PR description:**

This PR handles #6432 by mimicking the behaviour of Duplicatis [BackendManager](https://github.com/duplicati/duplicati/tree/master/Duplicati/Library/Main/Backend). In short, it disposes backends on error, tries to reinstantiate them a specified number of times. 

The PR also adds tests to check whether the remote synchronization tool can handle failing backends. It also adds `.ConfigureAwait(false)` and `CancellationToken` propagation to all of the asynchronous calls throughout the tool. 

When this PR has been merged, the [documentation](https://docs.duplicati.com/duplicati-programs/command-line-interface-cli-1/synctool) should be updated to reflect the changes.

## Working environment

The repository is checked out at `/app/duplicati` at this PR's **base commit**
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
