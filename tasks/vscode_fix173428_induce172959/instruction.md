# Code Review Task

You are a maintainer reviewing a pull request to the `microsoft/vscode` repository.

**PR title:** Improve GHES flow (#172959)

**PR description / commit message:**

Improve GHES flow (#172959)

* Improve GHES flow

It's clear to me now that a lot of users of the GHES flow have auth behind a VPN. Something that we cannot support in the OAuth flow because we require making a request to vscode.dev who makes a request to the GHES instance.

In light of this, we will remove the OAuth flow for GHES. Fear not, though... because both the Device Code Flow and the PAT flow are there and the PAT flow has been improved in 1.75... so in conclusion, I think GHES is handled as best we can with this PR.

Additionally, there is some "Hosted GitHub Enterprise" scenarios popping up, and this future proofs that by allowing "Hosted GitHub Enterprise" experiences to go through the OAuth flow because we know for a fact that they will be accessible from vscode.dev.

Fixes #169619
Fixes https://github.com/microsoft/vscode-internalbacklog/issues/3398

* Use api. sub domain and update telemetry logic

## Working environment

The repository is checked out at `/app/vscode` at this PR's **base commit**
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
