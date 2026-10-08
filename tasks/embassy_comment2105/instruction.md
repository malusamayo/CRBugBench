# Code Review Task

You are a maintainer reviewing a pull request to the `embassy-rs/embassy` repository.

**PR title:** Fix stm32 uart set_config

**PR description:**

* `CR1` `UE` must be false when setting word length and parity bits.
* use `type ConfigError = ConfigError` instead of `type ConfigError = ()`
* In mod.rs there is `fn configure()` which uses write to set `CR1`. This disables `RXNEIE` and `IDLEIE` in `CR1` and those must be re-enabled again. Otherwise receive does not work anymore.

# TODO (done)

- [x]  What to do with `fifoen`, which one is correct?

https://github.com/embassy-rs/embassy/blob/[reviewed commit redacted]/embassy-stm32/src/usart/mod.rs#L998-L999
vs
https://github.com/embassy-rs/embassy/blob/[reviewed commit redacted]/embassy-stm32/src/usart/buffered.rs#L236-L237

Edit: `usart_v4` is correct.

# TEST
Tested with stm32g081 by reconfiguring baudrate, parity and stop bits.

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
