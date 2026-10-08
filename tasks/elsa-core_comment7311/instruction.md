# Code Review Task

You are a maintainer reviewing a pull request to the `elsa-workflows/elsa-core` repository.

**PR title:** Distributed locks to prevent multiple pods executing Reload and Refresh

**PR description:**

## Purpose

Addition of Distributed locks to prevent multiple pods from triggering Reload or Refresh at the same time.

---

## Scope

Select one primary concern:
- [X] New feature

---

## Description
Distributed lock with generic lock has been added to `IWorkflowDefinitionsReloader` interface as a decorator. The goal is to prevent multiple pods from ever executing this action at the same time.

The same was done for `IWorkflowDefinitionsRefresher`, with the exception that the key to the distributed lock uses a combination of definition Ids from the request to allow it to be called by different pods with with different Requests.

### Problem
Double or multiple triggering of change notifications and updates/publishing of workflows.

### Solution
Distributed locks ensure no race between pods and only one action that should be singleton accross pods is taken.

## Working environment

The repository is checked out at `/app/elsa-core` at this PR's **base commit**
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
