# Code Review Task

You are a maintainer reviewing a pull request to the `netty/netty` repository.

**PR title:** Speed up base64 encoding of certs and keys

**PR description:**

Motivation:
Our SSL tests spend a lot time encoding certs and keys to their PEM representation, which involves base64 encoding. Our tests also run with leak detection enabled, which may trace on every buffer write. That's very slow.

Modification:
When possible, do our base64 encoding through a flattened unpooled buffer. Unpooled buffers don't have leak detection attached to them. We also ensure that our writes only go through a single buffer layer.

Result:
Our netty-handler tests, many of which involve SSL, now run much faster.

## Working environment

The repository is checked out at `/app/netty` at this PR's **base commit**
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
