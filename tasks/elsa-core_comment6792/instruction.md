# Code Review Task

You are a maintainer reviewing a pull request to the `elsa-workflows/elsa-core` repository.

**PR title:** Refactors workflow reference updates

**PR description:**

Streamlines workflow reference updating to improve dependency resolution and prevent concurrency issues.

- Introduces recursive dependency resolution to ensure all references are consistently updated.
- Prevents concurrent updates to avoid race conditions and data corruption.
- Simplifies activity descriptor creation with a dedicated factory.
- Employs topological sorting to process workflows in the correct order based on dependencies.

<!-- Reviewable:start -->
- - -
This change is [<img src="https://reviewable.io/review_button.svg" height="34" align="absmiddle" alt="Reviewable"/>](https://reviewable.io/reviews/elsa-workflows/elsa-core/6792)
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
