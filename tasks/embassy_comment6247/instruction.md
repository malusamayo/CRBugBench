# Code Review Task

You are a maintainer reviewing a pull request to the `embassy-rs/embassy` repository.

**PR title:** stm32: consolidate PR1-PR3 for PKA, SAES, and RNG API updates

**PR description:**

## Summary
- consolidate PR1-PR3 into one branch for coordinated cryptography/peripheral API review
- extend PKA ECC point support to 640-bit, expose SAES key-mode + async parity APIs, and add configurable RNG initialization policy APIs
- remove the newly added RNG low-power disable helper for now based on review feedback (needs refcount design first)
- keep commit history linear and scoped to `embassy-stm32`

## Included source branches
- `feat/stm32-pr1-pka-ecc-640bit`
- `feat/stm32-pr2-saes-keymode-async`
- `feat/stm32-pr3-rng-config-api`

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
