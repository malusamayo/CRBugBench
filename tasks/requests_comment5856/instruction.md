# Code Review Task

You are a maintainer reviewing a pull request to the `psf/requests` repository.

**PR title:** Fix inconsistent exception type in response.json() method

**PR description:**

## Summary
Fixes the inconsistency of errors thrown in the `response.json()` method in `models.py`, while preserving backwards compatibility. 

### What we used to have
Depending on whether or not `simplejson` was installed in the user's library, and whether the user was running Python 3+ versus Python 2, a different exception would get thrown when there was an issue with decoding response text as JSON. If `simplejson` was installed, `simplejson.JSONDecodeError` would get thrown. If not, `json.JSONDecodeError` would get thrown for Python 3+ users, and `ValueError` for Python 2 users. Thus, depending on the scenario, users would find themselves having to catch either `simplejson.JSONDecodeError`, `json.JSONDecodeError`, or `ValueError` in the case of the `response.json()` method failing. This inconsistency is not ideal.

### What we have now
There is now one error class in `exceptions.py` that will represent all errors that can be thrown or caught in the `response.json()` method: `requests.JSONDecodeError`. All `simplejson` functionality was replaced with `json` functionality, but the new error type aliases both `json.JSONDecodeError` and `simplejson.JSONDecodeError`. If `simplejson` is not installed, its `JSONDecodError` is replaced with a plain `Exception` when aliased. If the user is running Python 3+, `json.JSONDecodeError` is aliased, but if the user is running Python 2, that is replaced with `ValueError` when aliased, as the `JSONDecodeError` was not previously a part of the `json` library. Now, all five error types, `json.JSONDecodeError`, `simplejson.JSONDecodeError`, `ValueError`, and `requests.JSONDecodeError` and its parent class `requests.RequestException`, will be caught from the `requests.JSONDecodeError` that will be raised.

Fixes #5794
@sigmavirus24

## Working environment

The repository is checked out at `/app/requests` at this PR's **base commit**
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
