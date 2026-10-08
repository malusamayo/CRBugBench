# Code Review Task

You are a maintainer reviewing a pull request to the `vectordotdev/vector` repository.

**PR title:** chore: Use 'cargo hack' instead of check-component-features

**PR description:**

This commit replaces our check-component-features with 'cargo hack' to the same
purpose. We also remove the nightly check as it appears that it is recently
fixed.

Signed-off-by: Brian L. Troutwine <brian@troutwine.us>

<!--
**Your PR title must conform to the conventional commit spec!**

  <type>!?(<scope>): <description>

  * `type` = chore, enhancement, feat, fix
  * `!` = signals a breaking change
  * `scope` = https://github.com/timberio/vector/blob/master/.github/semantic.yml#L4
  * `description` = short description of the change

Examples:

  * enhancement(file source): Added `sort` option to sort discovered files
  * feat(new source): Initial `statsd` source
  * fix(file source): Fixed a bug discovering new files
  * chore(external docs): Clarified `batch_size` option
-->

## Working environment

The repository is checked out at `/app/vector` at this PR's **base commit**
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
