# Code Review Task

You are a maintainer reviewing a pull request to the `tock/tock` repository.

**PR title:** capsules: add button capsule implemented with the keyboard

**PR description:**

### Pull Request Overview

This adds a capsule which exposes the same syscall driver interface as the normal buttons capsule, but uses keyboard key presses instead of gpio pins. Boards pass in an array of key codes that will map to buttons indexed from 0.


### Testing Strategy

Working on the qemu board/tutorial.


### TODO or Help Wanted

Needs the keyboard-virtio PR which has the keyboard hil.


### Documentation Updated

- [x] Updated the relevant files in `/docs`, or no updates are required.

### Formatting

- [x] Ran `make prepush`.

## Working environment

The repository is checked out at `/app/tock` at this PR's **base commit**
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
