# Code Review Task

You are a maintainer reviewing a pull request to the `langchain4j/langchain4j` repository.

**PR title:** Anthropic: Support tools

**PR description:**

## Context
Anthropic recently began supporting tools: https://docs.anthropic.com/claude/docs/tool-use


## Change
This PR adds support for tools in `AnthropicChatModel`.
`AnthropicStreamingChatModel` does not support tools yet, because Anthropic does not support tools when streaming.


## Checklist
Before submitting this PR, please check the following points:
- [X] Test in AiServicesWithToolsIT
- [X] I have added unit and integration tests for my change
- [X] All unit and integration tests in the module I have added/changed are green
- [X] All unit and integration tests in the [core](https://github.com/langchain4j/langchain4j/tree/main/langchain4j-core) and [main](https://github.com/langchain4j/langchain4j/tree/main/langchain4j) modules are green
- [X] I have added/updated the [documentation](https://github.com/langchain4j/langchain4j/tree/main/docs/docs)
- [ ] I have added an example in the [examples repo](https://github.com/langchain4j/langchain4j-examples) (only for "big" features)
- [ ] I have added my new module in the [BOM](https://github.com/langchain4j/langchain4j/blob/main/langchain4j-bom/pom.xml) (only when a new module is added)

## Checklist for adding new embedding store integration
- [ ] I have added a {NameOfIntegration}EmbeddingStoreIT that extends from either EmbeddingStoreIT or EmbeddingStoreWithFilteringIT

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
