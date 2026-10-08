# Code Review Task

You are a maintainer reviewing a pull request to the `langchain4j/langchain4j` repository.

**PR title:** Revisit AiServices.tools() validation

**PR description:**

## Issue
<!-- Please specify the ID of the issue this PR is addressing. For example: "Closes #1234" or "Fixes #1234" -->
Closes #4028

## Change
<!-- Please describe the changes you made. -->
Changing the validation logic.


## General checklist
<!-- Please double-check the following points and mark them like this: [X] -->
- [ ] There are no breaking changes (API, behaviour) 
- [x] I have added unit and/or integration tests for my change
- [x] The tests cover both positive and negative cases
- [x] I have manually run all the unit and integration tests in the module I have added/changed, and they are all green
- [x] I have manually run all the unit and integration tests in the [core](https://github.com/langchain4j/langchain4j/tree/main/langchain4j-core) and [main](https://github.com/langchain4j/langchain4j/tree/main/langchain4j) modules, and they are all green
<!-- Before adding documentation and example(s) (below), please wait until the PR is reviewed and approved. -->
- [ ] I have added/updated the [documentation](https://github.com/langchain4j/langchain4j/tree/main/docs/docs)
- [ ] I have added an example in the [examples repo](https://github.com/langchain4j/langchain4j-examples) (only for "big" features)
- [ ] I have added/updated [Spring Boot starter(s)](https://github.com/langchain4j/langchain4j-spring) (if applicable)


## Checklist for adding new maven module
<!-- Please double-check the following points and mark them like this: [X] -->
- [ ] I have added my new module in the root `pom.xml` and `langchain4j-bom/pom.xml`


## Checklist for adding new embedding store integration
<!-- Please double-check the following points and mark them like this: [X] -->
- [ ] I have added a `{NameOfIntegration}EmbeddingStoreIT` that extends from either `EmbeddingStoreIT` or `EmbeddingStoreWithFilteringIT`
- [ ] I have added a `{NameOfIntegration}EmbeddingStoreRemovalIT` that extends from `EmbeddingStoreWithRemovalIT`

## Checklist for changing existing embedding store integration
<!-- Please double-check the following points and mark them like this: [X] -->
- [ ] I have manually verified that the `{NameOfIntegration}EmbeddingStore` works correctly with the data persisted using the latest released version of LangChain4j

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
