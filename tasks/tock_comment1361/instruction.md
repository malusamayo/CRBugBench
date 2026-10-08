# Code Review Task

You are a maintainer reviewing a pull request to the `tock/tock` repository.

**PR title:** thread: tlv: change u_bit operation

**PR description:**

### Pull Request Overview

This pull request is the result of checking for bit mask operations that don't do anything.

https://rust-lang.github.io/rust-clippy/master/index.html#bad_bit_mask

I'm not really sure what the intention of the code was, but I changed it to what the code is actually doing.


### Testing Strategy

This pull request was tested by travis.


### TODO or Help Wanted

n/a


### Documentation Updated

- [x] Updated the relevant files in `/docs`, or no updates are required.

### Formatting

- [x] Ran `make formatall`.

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
