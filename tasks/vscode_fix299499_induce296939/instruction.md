# Code Review Task

You are a maintainer reviewing a pull request to the `microsoft/vscode` repository.

**PR title:** Add diagnostics support to inline chat and related actions (#296939)

**PR description / commit message:**

Add diagnostics support to inline chat and related actions (#296939)

- Introduce `selectionHasDiagnostics` context key to track diagnostics in the editor selection.
- Implement `FixDiagnosticsAction` to allow users to fix diagnostics directly from inline chat.
- Enhance `InlineChatController` to optionally attach diagnostics to chat requests.
- Update inline chat configuration to include `FixDiagnostics` setting.
- Register new action in the inline chat affordance for fixing diagnostics.

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
