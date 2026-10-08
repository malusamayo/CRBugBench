# Code Review Task

You are a maintainer reviewing a pull request to the `libp2p/rust-libp2p` repository.

**PR title:** feat(websocket,websocket-websys): Add support for `/tls/ws`

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

To keep backward compatibility the following rules were implemented:

* On dialing, `/tls/ws` and `/wss` are equivalent.
* On listening:
  * If user listens with `/tls/ws` then `/tls/ws` will be advertised.
  * If user listens with `/wss` then `/wss` will be advertised.

Closes #2449 
Closes #5509

## Notes & open questions

<!--
Any notes, remarks or open questions you have to make about the PR which don't need to go into the final commit message.
-->

Doing the change directly in `multiaddr` crate as https://github.com/multiformats/rust-multiaddr/issues/100 suggests it would break compatibility and two different versions of libp2p that support websocket wouldn't be able to communicate. I decided to give the decision to the user by providing the listening address they want.

This PR contains all changes of #5525 PR, so merge that one first.

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
