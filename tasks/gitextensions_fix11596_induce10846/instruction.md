# Code Review Task

You are a maintainer reviewing a pull request to the `gitextensions/gitextensions` repository.

**PR title:** Avatars: increase a lot perf to download avatars

**PR description / commit message:**

Avatars: increase a lot perf to download avatars

by using the HttpClient class instead of WebClient

Example of gain (on blaming file `GitCommands/Git/GitModule.cs` after clearing avatars cache) : from 1m30s (WebClient)  to around 6s (HttpClient)

**Proxy feature not tested** but taken from:
https://stackoverflow.com/a/36803676/717372
https://stackoverflow.com/a/58560252/717372

## Working environment

The repository is checked out at `/app/gitextensions` at this PR's **base commit**
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
