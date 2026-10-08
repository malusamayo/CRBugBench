# Code Review Task

You are a maintainer reviewing a pull request to the `astral-sh/uv` repository.

**PR title:** Discover workspaces without using them in resolution (#3585)

**PR description / commit message:**

Discover workspaces without using them in resolution (#3585)

Add minimal support for workspace discovery, only used for determining
paths in the bluejay commands.

We can now discover the workspace structure, namely that the
`pyproject.toml` of a package belongs to a workspace `pyproject.toml`
with members and exclusion. The globbing logic is inspired by cargo. We
don't resolve `workspace = true` metadata declarations yet.

## Working environment

The repository is checked out at `/app/uv` at this PR's **base commit**
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
