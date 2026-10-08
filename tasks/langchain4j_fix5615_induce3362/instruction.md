# Code Review Task

You are a maintainer reviewing a pull request to the `langchain4j/langchain4j` repository.

**PR title:** [FEATURE] Anthropic support through Vertex AI #3193 (#3362)

**PR description / commit message:**

[FEATURE] Anthropic support through Vertex AI #3193 (#3362)

## Issue
Closes #3193
Closes #2739 

## Change
- introduce Google Vertex AI Anthropic support


## General checklist
- [X] There are no breaking changes
- [X] I have added unit and/or integration tests for my change
- [X] The tests cover both positive and negative cases
- [X] I have manually run all the unit and integration tests in the
module I have added/changed, and they are all green
- [] I have manually run all the unit and integration tests in the
[core](https://github.com/langchain4j/langchain4j/tree/main/langchain4j-core)
and
[main](https://github.com/langchain4j/langchain4j/tree/main/langchain4j)
modules, and they are all green
- [X] I have added/updated the
[documentation](https://github.com/langchain4j/langchain4j/tree/main/docs/docs)
- [ ] I have added an example in the [examples
repo](https://github.com/langchain4j/langchain4j-examples) (only for
"big" features)
- [ ] I have added/updated [Spring Boot
starter(s)](https://github.com/langchain4j/langchain4j-spring) (if
applicable)

## Checklist for adding new maven module
- [X] I have added my new module in the root `pom.xml` and
`langchain4j-bom/pom.xml`

---------

Co-authored-by: Petro Bykov <petrobykov@pbykov-lt.local>

## Working environment

The repository is checked out at `/app/langchain4j` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
