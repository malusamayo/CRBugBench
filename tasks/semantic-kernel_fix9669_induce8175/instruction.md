# Code Review Task

You are a maintainer reviewing a pull request to the `microsoft/semantic-kernel` repository.

**PR title:** .Net Agents - Add Streaming support for `OpenAIAssistantAgent` and `AgentChat` (#8175)

**PR description / commit message:**

.Net Agents - Add Streaming support for `OpenAIAssistantAgent` and `AgentChat` (#8175)

### Motivation and Context
<!-- Thank you for your contribution to the semantic-kernel repo!
Please help reviewers and future users, providing the following
information:
  1. Why is this change required?
  2. What problem does it solve?
  3. What scenario does it contribute to?
  4. If it fixes an open issue, please link to the issue here.
-->

Add streaming support to direct invocation of `OpenAIAssistantAgent` and
also `AgentChat`:

Fixes: https://github.com/microsoft/semantic-kernel/issues/4833
Fixes: https://github.com/microsoft/semantic-kernel/issues/5643

Integrates with existing streaming support for `ChatCompletionAgent`.

### Description
<!-- Describe your changes, the overall approach, the underlying design.
These notes will help understanding how your code works. Thanks! -->

Streaming returns the expected streaming content types as well as
providing whole messages in the provided history.

Support both agent invocation (no-chat) and via `AgentChat`.

Introduced:
- `StreamingAnnotationContent`
- `StreamingFileReferenceContent`

Added samples and tests.

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

---------

Co-authored-by: SergeyMenshykh <68852919+SergeyMenshykh@users.noreply.github.com>
Co-authored-by: Roger Barreto <19890735+RogerBarreto@users.noreply.github.com>
Co-authored-by: SergeyMenshykh <sergemenshikh@gmail.com>
Co-authored-by: Roger Barreto <rbarreto@microsoft.com>
Co-authored-by: Dmytro Struk <13853051+dmytrostruk@users.noreply.github.com>

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
