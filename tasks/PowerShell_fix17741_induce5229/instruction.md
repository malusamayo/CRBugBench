# Code Review Task

You are a maintainer reviewing a pull request to the `PowerShell/PowerShell` repository.

**PR title:** Add Test-Json cmdlet (NJsonSchema) (#5229)

**PR description / commit message:**

Add Test-Json cmdlet (NJsonSchema) (#5229)

Resolve #4220.

The cmdlet is based on NJsonSchema.
It allows to check:

JSON by only parsing
JSON against Schema
implicitly check Schema by parsing (based on previous line check)
NJsonSchema is under MIT (approved see https://github.com/PowerShell/PowerShell/pull/5229#issuecomment-342983215)

## Working environment

The repository is checked out at `/app/PowerShell` at this PR's **base commit**
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
