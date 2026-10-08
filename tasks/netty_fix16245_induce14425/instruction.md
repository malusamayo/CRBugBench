# Code Review Task

You are a maintainer reviewing a pull request to the `netty/netty` repository.

**PR title:** Fix epoll_wait retry loop (#14425)

**PR description / commit message:**

Fix epoll_wait retry loop (#14425)

Motivation:

Starting from Netty-4.1.76, scheduled tasks may be delayed or missed in
applications that are regularly interrupted by signals.

Modification:

Use decaying timeout in epoll_wait retry loop - measure the time spent
in an interrupted syscall, and reduce the remaining timeout value for
subsequence calls.

Result:

Scheduled tasks fired off at correct time. Reproduced and verified with
an example application -
https://github.com/dsidorov/netty-epoll-timer-example

Fixes #14368.

---------

Co-authored-by: Denis Sidorov <sidorovd@amazon.com>

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
