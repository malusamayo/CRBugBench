# Code Review Task

You are a maintainer reviewing a pull request to the `elastic/elasticsearch` repository.

**PR title:** ML: add migrate anomalies assistant

**PR description:**

This adds an endpoint, transport, and execution service for upgrading indices `.ml-anomailes*`.

We cannot use the upgrade plugin for these indices as they are already aliased for ML jobs.

The steps of the process are as follows
1. Create new write indices and include them in the read aliases
2. Point write aliases to the new write indices
3. make the old indices read only
4. reindex the old indices into new indices so that the old data is readable 
5. adjust the read aliases so that they point to the newly reindexed indices
6. Delete the old indices

This PR does NOT contain docs for this new endpoint, or the HLRC addition. The PR is getting pretty bloated, I will open a new one for docs + HLRC after this one gets approved and merged.

## Working environment

The repository is checked out at `/app/elasticsearch` at this PR's **base commit**
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
