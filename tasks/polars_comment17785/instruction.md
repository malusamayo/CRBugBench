# Code Review Task

You are a maintainer reviewing a pull request to the `pola-rs/polars` repository.

**PR title:** feat: Support `hf://` in  `read_(csv|ipc|ndjson)` functions

**PR description:**

For CSV and IPC, only `hf://` paths are dispatched to their `scan_*` equivalents. They can't dispatch for all paths as it would cause a breaking change to `storage_options` as they currently use `fsspec`, which uses different configuration keys. For CSV as well there is also the issue of compressed files.

`read_ndjson` doesn't suffer from the above issues, so I've added the full set of parameters from `scan_ndjson` and set it to always dispatch to `scan_ndjson`.

## Working environment

The repository is checked out at `/app/polars` at this PR's **base commit**
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
