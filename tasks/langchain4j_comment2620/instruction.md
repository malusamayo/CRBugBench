# Code Review Task

You are a maintainer reviewing a pull request to the `langchain4j/langchain4j` repository.

**PR title:** Add ConverseStream support for Amazon Bedrock integrations

**PR description:**

## Issue
Closes #2470 #2700

## Change
- add a BedrockStreamingChatModel
- implement Observability for BedrockChatModel
- allow adding additionalModelRequestFields (so that reasoning for Claude Sonnet 3.7 can be enabled) through BedrockChatRequestParameters

An AbstractBedrockChatModel allows to reduce code duplication between Streaming and non streaming chat model



## General checklist
<!-- Please double-check the following points and mark them like this: [X] -->
- [x] There are no breaking changes
- [x] I have added unit and/or integration tests for my change
- [ ] The tests cover both positive and negative cases
- [x] I have manually run all the unit and integration tests in the module I have added/changed, and they are all green
- [ ] I have manually run all the unit and integration tests in the [core](https://github.com/langchain4j/langchain4j/tree/main/langchain4j-core) and [main](https://github.com/langchain4j/langchain4j/tree/main/langchain4j) modules, and they are all green
<!-- Before adding documentation and example(s) (below), please wait until the PR is reviewed and approved. -->
- [ ] I have added/updated the [documentation](https://github.com/langchain4j/langchain4j/tree/main/docs/docs)
- [ ] I have added an example in the [examples repo](https://github.com/langchain4j/langchain4j-examples) (only for "big" features)
- [ ] I have added/updated [Spring Boot starter(s)](https://github.com/langchain4j/langchain4j-spring) (if applicable)

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
