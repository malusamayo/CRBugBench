# Code Review Task

You are a maintainer reviewing a pull request to the `astral-sh/uv` repository.

**PR title:** Add `--outdated` flag to `uv tool list` (#18318)

**PR description / commit message:**

Add `--outdated` flag to `uv tool list` (#18318)

## Summary

Add a `--outdated` flag that queries PyPI for the latest version of each
installed tool and filters the output to only show tools with available
updates. Each outdated tool is displayed with its installed version and
a `[latest: X.Y.Z]` annotation.

The implementation reuses the existing `LatestClient` infrastructure
from `pip list --outdated`, fetching versions concurrently with progress
reporting. Up-to-date tools are omitted from the output. A
`--no-outdated` hidden flag is included for flag negation consistency.

Fixes #9309

## Test Plan

A new integration test has been created in
`crates/uv/tests/it/tool_list.rs`, and the feature has also been tested
locally.

Signed-off-by: Mikaël Barbero <mikael.barbero@eclipse-foundation.org>
Co-authored-by: Claude Opus 4.6 <noreply@anthropic.com>

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
