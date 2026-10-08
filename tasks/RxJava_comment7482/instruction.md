# Code Review Task

You are a maintainer reviewing a pull request to the `ReactiveX/RxJava` repository.

**PR title:** Add onDropped callback for throttleFirst - addresses #7481

**PR description:**

This PR adds an overload to the throttleFirst operator which takes an onDropped consumer.

This consumer is called when we're still within the gated time window when any new item isn't passed to downstream.

If the onDropped crashes, the exception is either delivered to the downstream (if the sequence is still live at that point) or to the global error handler (sequence is stopped).

Related: #7458

## Working environment

The repository is checked out at `/app/RxJava` at this PR's **base commit**
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
