# Code Review Task

You are a maintainer reviewing a pull request to the `langgenius/dify` repository.

**PR title:** fix: eagerly validate conversation before generator to prevent hanging

**PR description:**

## Summary

When a non-existing `conversation_id` is provided to the chat-messages API, the error was raised inside a generator function, making it impossible for the outer `try/except` to catch. This caused the request to hang with only ping events instead of returning a proper 4xx error.

## Root Cause

The `ConversationNotExistsError` is raised inside the `generate()` generator method of the app generator. Since Python generators execute lazily, the exception happens during iteration (inside Flask's SSE stream processing), not during the function call. The `try/except` in the controller can't catch it.

## Fix

Add eager pre-validation of the conversation **before** calling `AppGenerateService.generate()` in three completion endpoints:

- `controllers/web/completion.py` — Web app chat-messages endpoint
- `controllers/service_api/app/completion.py` — Service API completion endpoint  
- `controllers/console/app/completion.py` — Console (debugger) completion endpoint

The pre-validation calls `ConversationService.get_conversation()` which raises `ConversationNotExistsError` immediately, outside the generator context, so it's properly caught and returns 404.

## Test plan

- [x] Invalid `conversation_id` now returns 404 immediately instead of hanging
- [x] Valid `conversation_id` works unchanged
- [x] No `conversation_id` provided works unchanged

Fixes #37197

## Working environment

The repository is checked out at `/app/dify` at this PR's **base commit**
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
