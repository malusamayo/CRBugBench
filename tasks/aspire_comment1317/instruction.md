# Code Review Task

You are a maintainer reviewing a pull request to the `microsoft/aspire` repository.

**PR title:** Add WithVolumeMountForData

**PR description:**

Make it easier to use external volumes for database containers:
- Added WithVolumeFor.../WithBindMountFor... for data, logs and init folders
  - For the data directory on all containers
  - For the logs directory on containers with logs enabled by default (as it might confuse if the WithVolumeForLogs is available but log files are not actually enabled in the container configuration)
  - For the init folder where a /docker-entrypoint-initdb.d folder is avilable (did not find something similar on the other containers)

Fixes https://github.com/dotnet/aspire/issues/837
 ###### Microsoft Reviewers: [Open in CodeFlow](https://microsoft.github.io/open-pr/?codeflow=https://github.com/dotnet/aspire/pull/1317)

## Working environment

The repository is checked out at `/app/aspire` at this PR's **base commit**
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
