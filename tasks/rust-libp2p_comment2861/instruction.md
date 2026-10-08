# Code Review Task

You are a maintainer reviewing a pull request to the `libp2p/rust-libp2p` repository.

**PR title:** swarm/connection: Enforce limit on inbound substreams via `StreamMuxer`

**PR description:**

# Description

<!-- Please write a summary of your changes and why you made them.-->

Inlines the `HandlerWrapper` component into `Connection` which allows us to enforce the limit of inbound streams directly down to the `StreamMuxer` level by not calling `poll_inbound` if we would exceed the limit. Depending on the muxer implementation, this may enforce backpressure all the way to the other node.

Due to this backpressure mechanism, a remote may now be slow in accepting new outbound streams. To prevent unbounded growth of "pending" streams, we change the implementation such that the "upgrade timeout" for outbound streams starts ticking from the moment the stream is requested instead of only from when the stream is opened and we start the upgrade.

Fixes #2796.

## Links to any relevant issues

<!-- Reference any related issues.-->

## Open tasks

- [x] Find out why we had to adjust the `Connection::poll` implementation
- [x] Start substream upgrade timeout at the time of substream _request_ and not when the upgrade starts
- [x] Add changelog entry to yamux & bump version

## Open Questions

<!-- Unresolved questions, if any. -->

- How many streams should we buffer at most in `libp2p-yamux::Yamux`?
- Should the change to `libp2p-yamux` be in a separate PR?

## Change checklist

<!-- Please add a Changelog entry in the appropriate crates and bump the crate versions if needed. See <https://github.com/libp2p/rust-libp2p/blob/master/docs/release.md#development-between-releases>-->

- [x] I have performed a self-review of my own code
- [x] I have made corresponding changes to the documentation
- [x] I have added tests that prove my fix is effective or that my feature works
- [x] A changelog entry has been made in the appropriate crates

## Working environment

The repository is checked out at `/app/rust-libp2p` at this PR's **base commit**
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
