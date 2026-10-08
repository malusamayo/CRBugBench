# Code Review Task

You are a maintainer reviewing a pull request to the `libp2p/rust-libp2p` repository.

**PR title:** refactor(request-response): don't use upgrade infrastructure

**PR description:**

## Description

This patch refactors `libp2p-request-response` to not use the "upgrade infrastructure" provided by `libp2p-swarm`. Instead, we directly convert the negotiated streams into futures that read and write the messages.

Related: #3268.
Related: #2863.

<!--
Please write a summary of your changes and why you made them.
This section will appear as the commit message after merging.
Please craft it accordingly.
For a quick primer on good commit mesages, check out this blog post: https://cbea.ms/git-commit/

Please include any relevant issues in here, for example:

Related https://github.com/libp2p/rust-libp2p/issues/ABCD.
Fixes https://github.com/libp2p/rust-libp2p/issues/XYZ.
-->

## Attributions

Co-authored-by: Yiannis Marangos <yiannis@eiger.co>

## Notes & open questions

~I am putting this up as an initial draft. I think some clean-up can be done but overall, I am glad it is working this well.~

<!--
Any notes, remarks or open questions you have to make about the PR which don't need to go into the final commit message.
-->

## Change checklist

<!-- Please add a Changelog entry in the appropriate crates and bump the crate versions if needed. See <https://github.com/libp2p/rust-libp2p/blob/master/docs/release.md#development-between-releases>-->

- [ ] I have performed a self-review of my own code
- [ ] I have made corresponding changes to the documentation
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] A changelog entry has been made in the appropriate crates

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
