# Code Review Task

You are a maintainer reviewing a pull request to the `netty/netty` repository.

**PR title:** Add support for IP_MULTICAST_ALL to EpollDatagramChannel and IOUringDatagramChannel (#15755)

**PR description / commit message:**

Add support for IP_MULTICAST_ALL to EpollDatagramChannel and IOUringDatagramChannel (#15755)

Motivation:

IP multicast behaviour varies between Windows and Linux.

On Windows, you only receive datagrams for the groups your socket has
joined.

On Linux, by default, you receive datagrams for all groups joined by the
host.

This behaviour can be controlled using the IP_MULTICAST_ALL (or
IPV6_MULTICAST_ALL) socket option - it is set to 1 by default.

OpenJDK sets this to 0 on all NIO and Net multicast channels, it is not
configurable.

This PR makes the option configurable for epoll socket channels, so that
behaviour can be made consistent between NIO and native datagram
channels.

Modification:

Add IP_MULTICAST_ALL and IPV6_MULTICAST_ALL options to native epoll
transport and native io uring transport.

Set IP_MULTICAST_ALL to 0 when constructing epoll and io uring datagram
channels.

Result:

Fixes https://github.com/netty/netty/issues/15753.

---------

Co-authored-by: Norman Maurer <norman_maurer@apple.com>

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
