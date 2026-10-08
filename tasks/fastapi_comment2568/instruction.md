# Code Review Task

You are a maintainer reviewing a pull request to the `fastapi/fastapi` repository.

**PR title:** ✨ Enable configuring Swagger UI parameters

**PR description:**

At present there are a number of [Swagger UI parameters](https://swagger.io/docs/open-source-tools/swagger-ui/usage/configuration/) that are not configurable when using FastAPI. Under normal circumstances most of these wouldn't need to be used at all, however there are some cases where you might need to override some of these. For example, Swagger UI's syntax highlighting is [known to be slow](https://github.com/swagger-api/swagger-ui/issues/3832), and being able to easily disable this would be very useful in certain situations.

## Working environment

The repository is checked out at `/app/fastapi` at this PR's **base commit**
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
