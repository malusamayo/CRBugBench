# Code Review Task

You are a maintainer reviewing a pull request to the `langchain4j/langchain4j` repository.

**PR title:** DashScope: Support tool-call for QwenStreamingChatModel

**PR description:**

## Issue
<!-- Please specify the ID of the issue this PR is addressing. For example: "Closes #1234" or "Fixes #1234" -->
Closes #1994

## Change
Support tool-call for QwenStreamingChatModel.
And Optimize switch-case statements.

## General checklist
<!-- Please double-check the following points and mark them like this: [X] -->
- [X] There are no breaking changes
- [X] I have added unit and integration tests for my change
- [X] I have manually run all the unit and integration tests in the module I have added/changed, and they are all green
- [ ] I have manually run all the unit and integration tests in the [core](https://github.com/langchain4j/langchain4j/tree/main/langchain4j-core) and [main](https://github.com/langchain4j/langchain4j/tree/main/langchain4j) modules, and they are all green

## Working environment

The repository is checked out at `/app/langchain4j` at this PR's **base commit**
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
