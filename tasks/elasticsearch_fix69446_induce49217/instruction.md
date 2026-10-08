# Code Review Task

You are a maintainer reviewing a pull request to the `elastic/elasticsearch` repository.

**PR title:** Fix RepoCleanup not Removed on Master-Failover (#49217)

**PR description / commit message:**

Fix RepoCleanup not Removed on Master-Failover (#49217)

The logic for `cleanupInProgress()` was backwards everywhere (method itself and
all but one user). Also, we weren't checking it when removing a repository.

This lead to a bug (in the one spot that didn't use the method backwards) that prevented
the cleanup cluster state entry from ever being removed from the cluster state if master
failed over during the cleanup process.

This change corrects the backwards logic, adds a test that makes sure the cleanup
is always removed and adds a check that prevents repository removal during cleanup
to the repositories service.

Also, the failure handling logic in the cleanup action was broken. Repeated invocation would lead to the cleanup being removed from the cluster state even if it was in progress. Fixed by adding a flag that indicates whether or not any removal of the cleanup task from the cluster state must be executed. Sorry for mixing this in here, but I had to fix it in the same PR, as the first test (for master-failover) otherwise would often just delete the blocked cleanup action as a result of a transport master action retry.

## Working environment

The repository is checked out at `/app/elasticsearch` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
