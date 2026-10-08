# Code Review Task

You are a maintainer reviewing a pull request to the `elsa-workflows/elsa-core` repository.

**PR title:** Refactor OpenTelemetry error handling implementation

**PR description:**

Introduce WorkflowErrorSpanHandler interface and context for improved error span handling in workflows. Separate activity and workflow error handling using dedicated abstractions and context models. Update error handling logic in tracing middleware and adjust DI configuration accordingly.

<img width="1783" alt="image" src="https://github.com/user-attachments/assets/8da27e6e-5e47-4888-b376-91c3b6b4eb3f" />

<!-- Reviewable:start -->
- - -
This change is [<img src="https://reviewable.io/review_button.svg" height="34" align="absmiddle" alt="Reviewable"/>](https://reviewable.io/reviews/elsa-workflows/elsa-core/6621)
<!-- Reviewable:end -->

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
