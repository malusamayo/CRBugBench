# Code Review Task

You are a maintainer reviewing a pull request to the `langchain4j/langchain4j` repository.

**PR title:** Ollama Tools Support - only in OllamaChatModel (#1558)

**PR description / commit message:**

Ollama Tools Support - only in OllamaChatModel (#1558)

## Issue
Closes #1525
Closes #318

## Change
Add new DTOs to support Tool/Function calling.
Add new integration test and model configuration that supports Tool
Calls - Mistral
Modify some class to support Tool calling, for example
`OllamaChatModel`, `Role`

As stated here https://ollama.com/blog/tool-support, tools support is
not possible in streaming scenario - for now

I got the best results with the Mistral model, but without a
SystemMessage, it always wants to call a tool, even if it doesn't make
any sense. With Llama 3.1, it properly returns a ToolCallRequest but
ignores the result.

## General checklist
<!-- Please double-check the following points and mark them like this:
[X] -->
- [X] There are no breaking changes
- [X] I have added unit and integration tests for my change
- [X] I have manually run all the unit and integration tests in the
module I have added/changed, and they are all green
- [ ] I have manually run all the unit and integration tests in the
[core](https://github.com/langchain4j/langchain4j/tree/main/langchain4j-core)
and
[main](https://github.com/langchain4j/langchain4j/tree/main/langchain4j)
modules, and they are all green
<!-- Before adding documentation and example(s) (below), please wait
until the PR is reviewed and approved. -->
- [ ] I have added/updated the
[documentation](https://github.com/langchain4j/langchain4j/tree/main/docs/docs)
- [ ] I have added an example in the [examples
repo](https://github.com/langchain4j/langchain4j-examples) (only for
"big" features)
- [ ] I have added/updated [Spring Boot
starter(s)](https://github.com/langchain4j/langchain4j-spring) (if
applicable)

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
