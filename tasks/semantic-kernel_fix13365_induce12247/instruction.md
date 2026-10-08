# Code Review Task

You are a maintainer reviewing a pull request to the `microsoft/semantic-kernel` repository.

**PR title:** Python: Support Declarative Spec for OpenAIAssistantAgent & OpenAIResponsesAgent (#12247)

**PR description / commit message:**

Python: Support Declarative Spec for OpenAIAssistantAgent & OpenAIResponsesAgent (#12247)

### Motivation and Context

This PR builds on the initial work/abstractions from #11982. The
`AzureAssistantAgent` / `OpenAIAssistantAgent` as well as the
`AzureResponsesAgent` / `OpenAIResponsesAgent` now support declarative
specs. Several examples on how to declare the spec are shown in the
respective dirs in `samples/concepts/agents`, as well as a simple
getting started example for each agent type.

To further simplify working with these two agents, the
`setup_resources()` methods for each agent type have been marked with a
deprecation tag. The new method to use is
`OpenAIAssistantAgent.create_client()` or
`OpenAIResponsesAgent.create_client()`. Further, when one needs to
access the underlying setting's, it's simple to do so with a settings
object and accessing the attribute.

In the previous PR for the AzureAIAgent, it lacked support for
templating - this is included in this current PR.

<!-- Thank you for your contribution to the semantic-kernel repo!
Please help reviewers and future users, providing the following
information:
  1. Why is this change required?
  2. What problem does it solve?
  3. What scenario does it contribute to?
  4. If it fixes an open issue, please link to the issue here.
-->

### Description

Bring in support for the declarative single agent spec for these agent
types.
- Add samples
- Add unit tests
- Add support for prompt templates for all current agent types
- Closes #11979

<!-- Describe your changes, the overall approach, the underlying design.
These notes will help understanding how your code works. Thanks! -->

### Contribution Checklist

<!-- Before submitting this PR, please make sure: -->

- [X] The code builds clean without any errors or warnings
- [X] The PR follows the [SK Contribution
Guidelines](https://github.com/microsoft/semantic-kernel/blob/main/CONTRIBUTING.md)
and the [pre-submission formatting
script](https://github.com/microsoft/semantic-kernel/blob/main/CONTRIBUTING.md#development-scripts)
raises no violations
- [X] All unit tests pass, and I have added new tests where possible
- [X] I didn't break anyone :smile:

## Working environment

The repository is checked out at `/app/semantic-kernel` at this PR's **base commit**
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
