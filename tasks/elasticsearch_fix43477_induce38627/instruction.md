# Code Review Task

You are a maintainer reviewing a pull request to the `elastic/elasticsearch` repository.

**PR title:** Fix intermittent failure in ApiKeyIntegTests (#38627)

**PR description / commit message:**

Fix intermittent failure in ApiKeyIntegTests (#38627)

Few tests failed intermittently and most of the
times due to invalidated or expired keys that were
deleted were still reported in search results.
This commit removes the test and adds enhancements
to other tests testing different scenario's.

When ExpiredApiKeysRemover is triggered, the tests
did not await its termination thereby sometimes
the results would be wrong for a search operation.

DELETE_INTERVAL setting has been further reduced to
100ms so we can trigger ExpiredApiKeysRemover faster.

Closes #38408

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
