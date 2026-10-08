# Code Review Task

You are a maintainer reviewing a pull request to the `dotnet/roslyn` repository.

**PR title:** Allow didChange to operate on tracked source text directly

**PR description:**

Fixes https://github.com/dotnet/roslyn/issues/50875

Creating the solution that represents the LSP view of the world is showing up in perf traces, so this PR introduces a new flag, `SkipBuildingLSPSolution`, that lets handlers opt out of that work. In doing so they are declaring they will not access text information since it will be out of date, though there aren't great contracts we can enforce there.

This also updates the text sync handlers to use this new system to remove this work from the current local LSP server.

## Working environment

The repository is checked out at `/app/roslyn` at this PR's **base commit**
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
