# Code Review Task

You are a maintainer reviewing a pull request to the `apache/flink` repository.

**PR title:** [FLINK-23496][ci] Use MVN_GLOBAL_OPTIONS during maven snapshot deployment

**PR description:**

- splits MVN_GLOBAL_OPTIONS so that usages can use the majority of the options without the `--settings`, in case they also set it
- modify the nightly maven snapshot deployment to make use of this new property

This improves logging (by removing the download progress messages) and deduplicates optimizations (maven.wagon.http.pool).

This isn't the ideal solution, which would be to just call `run_mvn`, but I think this is a slightly safer option.

## Working environment

The repository is checked out at `/app/flink` at this PR's **base commit**
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
