# Code Review Task

You are a maintainer reviewing a pull request to the `tensorflow/tfjs` repository.

**PR title:** [WASM] Fix bug where we try to set more memory on WASM heap tha… (#2591)

**PR description / commit message:**

[WASM] Fix bug where we try to set more memory on WASM heap tha… (#2591)

BUG

If a values TypedArray is passed to the WASM backend we:
1) malloc bytes based on the shape, dtype
2) set the buffer based on the values buffer size.

However, the values buffer size could not match the size of the values array itself because values can be a view of a larger buffer (e.g. with Array.subarray()).

This makes sure we only set into the WASM heap the number of bytes we've actually malloc'd.

The unit test I wrote to catch this is now in core (as all backends need this to be true) and I verified it crashes the page without the fix.

## Working environment

The repository is checked out at `/app/tfjs` at this PR's **base commit**
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
