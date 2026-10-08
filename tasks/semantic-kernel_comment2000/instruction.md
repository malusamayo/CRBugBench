# Code Review Task

You are a maintainer reviewing a pull request to the `microsoft/semantic-kernel` repository.

**PR title:** .Net: Add custom PromptConfig to Stepwise Planner

**PR description:**

### Motivation and Context

<!-- Thank you for your contribution to the semantic-kernel repo!
Please help reviewers and future users, providing the following information:
  1. Why is this change required? : 
  3. What problem does it solve?
  4. What scenario does it contribute to?
  5. If it fixes an open issue, please link to the issue here.
-->

In case of custom prompt, allow sending custom prompt config. This is useful for custom prompt to Stepwise Planner having additional parameters.

### Description

<!-- Describe your changes, the overall approach, the underlying design.
     These notes will help understanding how your code works. Thanks! -->

This allow stepwise planner to be created with custom prompt and custom prompt config

### Contribution Checklist

<!-- Before submitting this PR, please make sure: -->

- [x] The code builds clean without any errors or warnings
- [x] The PR follows the [SK Contribution Guidelines](https://github.com/microsoft/semantic-kernel/blob/main/CONTRIBUTING.md) and the [pre-submission formatting script](https://github.com/microsoft/semantic-kernel/blob/main/CONTRIBUTING.md#dev-scripts) raises no violations
- [x] All unit tests pass, and I have added new tests where possible
- [x] I didn't break anyone :smile:

## Working environment

The repository is checked out at `/app/semantic-kernel` at this PR's **base commit**
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
