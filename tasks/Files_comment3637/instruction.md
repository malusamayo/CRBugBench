# Code Review Task

You are a maintainer reviewing a pull request to the `files-community/Files` repository.

**PR title:** Made some enhancements to the Bundles widget

**PR description:**

This PR polishes and fine-tunes [Bundles PR](https://github.com/files-community/Files/pull/2881). This is the final part that completes [Bundles](https://github.com/files-community/Files/pull/2881)

**Things yet to do**
- [x] Option to rearrange Bundle items by dragging
- [x] Select items upon `OpenPath` navigation
- [x] Ability to rearrange Bundles
- [x] Support for adding shourtcut files #3270
- [x] Display warning when creating a Bundle if the name already exists #3449
- [x] Add option to open folders in bundle in new pane
- [x] Fix memory leaks
- [x] Improve DynamicDialog (auto focus on DisplayControl) #3724 

Closes #3449
Closes #3270
Closes #3724

## Working environment

The repository is checked out at `/app/Files` at this PR's **base commit**
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
