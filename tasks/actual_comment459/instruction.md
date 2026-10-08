# Code Review Task

You are a maintainer reviewing a pull request to the `actualbudget/actual` repository.

**PR title:** Move the “…” menu to the budget name

**PR description:**

Rationale:

- this further differentiates the “…” menu in the account view from the budget file menu
- this matches lots of other UIs where top-level actions go under the name of the thing (including Discord)
- renaming a budget isn’t a very common action<sup>[*citation needed*]</sup>, so making it require an extra click isn’t too bad (and arguably it’s more discoverable now that you can get to it by clicking on the visible down arrow indicator and then choosing the “rename” option

<img width="239" alt="Screenshot_2023-01-13 17 38 45" src="https://user-images.githubusercontent.com/25517624/212432001-416c6bef-b31f-4b6a-ac7e-b3afb8f4c2ab.png">

## Working environment

The repository is checked out at `/app/actual` at this PR's **base commit**
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
