# Code Review Task

You are a maintainer reviewing a pull request to the `dotnet/maui` repository.

**PR title:** Implement `PointerGestureRecognizer` Buttons (#31214)

**PR description / commit message:**

Implement `PointerGestureRecognizer` Buttons (#31214)

* Add initial support for Buttons PointerGestureRecognizer desktop

* Add `PointerGestureRecognizer` Buttons macOS and Android implementation

* Adjust PublicAPI surface area for PointerGestureRecognizer

* Adjustments and add UI test

* Properly filter pointer gesture button recognizer mask

* Update Callback from Copilot review

Co-authored-by: Copilot <175728472+Copilot@users.noreply.github.com>

* Enhance `PointerGestureRecognizer` button handling for default button mask and refactor pointer event methods

* Fire PointerReleased immediately instead of delaying

* Add remarks for secondary button in PointerReleased event for mac and ios

---------

Co-authored-by: Copilot <175728472+Copilot@users.noreply.github.com>

## Working environment

The repository is checked out at `/app/maui` at this PR's **base commit**
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
