# Code Review Task

You are a maintainer reviewing a pull request to the `excalidraw/excalidraw` repository.

**PR title:** feat: expose variable window.EXCALIDRAW_ASSET_PATH to allow host define the path for excalidraw assets (#3068)

**PR description / commit message:**

feat: expose variable window.EXCALIDRAW_ASSET_PATH to allow host define the path for excalidraw assets (#3068)

* feat: expose variable window.EXCALIDRAW_ASSET_PATH to allow host define the path for excalidraw assets
No more __webpack_public_path__ needed explicitly in host and it will default to unpkg cdn if window.EXCALIDRAW_ASSET_PATH is not defined

* fix

* add public path

* add public path

* assign only when env not test

* read from package.json

* Append content hash to excalidraw-assets so cache bursting happens when version update

* update changelog and readme

* update

## Working environment

The repository is checked out at `/app/excalidraw` at this PR's **base commit**
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
