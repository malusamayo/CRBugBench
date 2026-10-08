# Code Review Task

You are a maintainer reviewing a pull request to the `alibaba/spring-ai-alibaba` repository.

**PR title:** feat(agent): add streamMessages API for agent streaming

**PR description:**

### Describe what this PR does / why we need it

This PR introduces `streamMessages(...)` as an additional streaming API option alongside `stream(...)`, intended for use cases that do not require graph orchestration.

### Does this pull request fix one issue?

Related to #4023

### Describe how you did it
Adds `streamMessages(...)`, and converts the original return type of `stream(...)` from `Flux<NodeOutput>` to `Flux<Message>`.

### Describe how to verify it
run Test `StreamAgentTest`

### Special notes for reviews
None

## Working environment

The repository is checked out at `/app/spring-ai-alibaba` at this PR's **base commit**
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
