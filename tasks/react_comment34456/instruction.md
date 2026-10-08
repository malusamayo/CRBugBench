# Code Review Task

You are a maintainer reviewing a pull request to the `react/react` repository.

**PR title:** Allow running `download_devtools_regression_build.js` on a clean repo

**PR description:**

Previous version relied on having built something before. These changes make the script work on a fresh clone/worktree. Technically you do need to run `yarn build react-debug-tools react-refresh internal-test-utils` because we're not actually doing regression tests for those packages but that's an issue for the tests using those package. The other tests should be able to run on a clean worktree.

This is also fixing a bug where we were using the built `react-is` not the published one.

## Test plan

`node ./scripts/ci/download_devtools_regression_build.js 16.0 --replaceBuild` on
- only a fresh worktree
- repeatedly

## Working environment

The repository is checked out at `/app/react` at this PR's **base commit**
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
