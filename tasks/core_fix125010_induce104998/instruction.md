# Code Review Task

You are a maintainer reviewing a pull request to the `home-assistant/core` repository.

**PR title:** Bump openai end switch from dall-e-2 to dall-e-3 (#104998)

**PR description / commit message:**

Bump openai end switch from dall-e-2 to dall-e-3 (#104998)

* Bump openai

* Fix tests

* Apply suggestions from code review

* Undo conftest changes

* Raise repasir issue

* Explicitly use async mock for chat.completions.create

It is not always detected correctly as async because it uses a decorator

* removed duplicated message

* ruff

* Compatibility with old pydantic versions

* Compatibility with old pydantic versions

* More tests

* Apply suggestions from code review

Co-authored-by: Paulus Schoutsen <paulus@home-assistant.io>

* Apply suggestions from code review

---------

Co-authored-by: Paulus Schoutsen <paulus@home-assistant.io>

## Working environment

The repository is checked out at `/app/core` at this PR's **base commit**
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
