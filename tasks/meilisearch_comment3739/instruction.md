# Code Review Task

You are a maintainer reviewing a pull request to the `meilisearch/meilisearch` repository.

**PR title:** fix: update `payload_too_large` error message to include human readable maximum acceptable payload size

**PR description:**

# Pull Request

## Related issue
Fixes #3736 

## What does this PR do?
- update `payload_too_large` error message as requested in ticket

## PR checklist
Please check if your PR fulfills the following requirements:
- [x] Does this PR fix an existing issue, or have you listed the changes applied in the PR description (and why they are needed)?
- [x] Have you read the contributing guidelines?
- [x] Have you made sure that the title is accurate and descriptive of the changes?

Thank you so much for contributing to Meilisearch!

## Working environment

The repository is checked out at `/app/meilisearch` at this PR's **base commit**
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
