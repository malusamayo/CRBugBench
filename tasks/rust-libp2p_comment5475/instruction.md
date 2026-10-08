# Code Review Task

You are a maintainer reviewing a pull request to the `libp2p/rust-libp2p` repository.

**PR title:** feat(kad): Return multiaddrs alognside peer IDs

**PR description:**

## Description

<!--
Please write a summary of your changes and why you made them.
This section will appear as the commit message after merging.
Please craft it accordingly.
For a quick primer on good commit messages, check out this blog post: https://cbea.ms/git-commit/

Please include any relevant issues in here, for example:

Related https://github.com/libp2p/rust-libp2p/issues/ABCD.
Fixes https://github.com/libp2p/rust-libp2p/issues/XYZ.
-->

## Notes & open questions

<!--
Any notes, remarks or open questions you have to make about the PR which don't need to go into the final commit message.
-->

## Change checklist

<!-- Please add a Changelog entry in the appropriate crates and bump the crate versions if needed. See <https://github.com/libp2p/rust-libp2p/blob/master/docs/release.md#development-between-releases>-->

- [x] I have performed a self-review of my own code
- [ ] I have made corresponding changes to the documentation
- [ ] I have added tests that prove my fix is effective or that my feature works
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
