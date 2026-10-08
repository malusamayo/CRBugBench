# Code Review Task

You are a maintainer reviewing a pull request to the `libp2p/rust-libp2p` repository.

**PR title:** feat(transports/quic): Add implementation based on `quinn-proto` (#2289)

**PR description / commit message:**

feat(transports/quic): Add implementation based on `quinn-proto` (#2289)

Co-authored-by: Demi Marie Obenour <demiobenour@gmail.com>
Co-authored-by: Pierre Krieger <pierre.krieger1708@gmail.com>
Co-authored-by: David Craven <david@craven.ch>
Co-authored-by: Max Inden <mail@max-inden.de>
Co-authored-by: Thomas Eizinger <thomas@eizinger.io>
Co-authored-by: elenaf9 <elena.frank@protonmail.com>
Co-authored-by: Marco Munizaga <marco@marcopolo.io>

## Working environment

The repository is checked out at `/app/rust-libp2p` at this PR's **base commit**
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
