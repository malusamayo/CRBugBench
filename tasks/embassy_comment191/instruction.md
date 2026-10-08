# Code Review Task

You are a maintainer reviewing a pull request to the `embassy-rs/embassy` repository.

**PR title:** Add support for STM32L0 family

**PR description:**

@Dirbaio I've tried to split the PR into isolated commits, so its only the last commit that regenrates all the PACs. I'm not sure how best to update the submodule, but it requires changes from https://github.com/embassy-rs/stm32-data/pull/25

I've been able to compile and run on stm32l072cz, but I'm currently debugging why LED can't blink :P 

@bobmcwhirter FYI, RNG changes are included here.

## Working environment

The repository is checked out at `/app/embassy` at this PR's **base commit**
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
