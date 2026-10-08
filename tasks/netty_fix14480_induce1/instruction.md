# Code Review Task

You are a maintainer reviewing a pull request to the `netty/netty` repository.

**PR title:** Merge commit from fork

**PR description / commit message:**

Merge commit from fork

Motivation:

We didnt verify the amount of data buffered while reading files / streams during startup which could allow an attacker to cause an OMME if the attacker was able to create a massive file.

Modifications:

Decorate InputStream with own that will throw an exception once we reach the limit of data read.

Result:

No more risk of OOME

## Working environment

The repository is checked out at `/app/netty` at this PR's **base commit**
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
