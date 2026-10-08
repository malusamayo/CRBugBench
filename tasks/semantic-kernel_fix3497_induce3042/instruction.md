# Code Review Task

You are a maintainer reviewing a pull request to the `microsoft/semantic-kernel` repository.

**PR title:** .Net: Memory Plugin extraction - Part 1 (#3042)

**PR description / commit message:**

.Net: Memory Plugin extraction - Part 1 (#3042)

### Motivation and Context

<!-- Thank you for your contribution to the semantic-kernel repo!
Please help reviewers and future users, providing the following
information:
  1. Why is this change required?
  2. What problem does it solve?
  3. What scenario does it contribute to?
  4. If it fixes an open issue, please link to the issue here.
-->

This PR is based on feature branch created by @shawncal:
https://github.com/microsoft/semantic-kernel/tree/feature/memory-plugin

The changes include moving part of Memory-related logic to separate
`Plugins.Memory` project, as preparation to remove `Memory` property
from `Kernel` type (which will be added as Part 2 of this task). More
information is available in ADR.

Part 2 of this task will be available as soon as the other task
regarding service/plugin registration in Kernel will be implemented and
merged to `main` branch. In this case, it will be possible to remove
Memory logic from main packages completely, and inject Memory as Plugin
into other Plugins that require it.

### Description

<!-- Describe your changes, the overall approach, the underlying design.
These notes will help understanding how your code works. Thanks! -->
1. Created new project `Plugins.Memory`. 
2. Moved Memory-related logic to `Plugins.Memory` project.
3. Moved Memory-related unit tests to `Plugins.UnitTests` project.
4. Added `Plugins.Memory` project as part of Semantic Kernel
metapackage.
5. Updated access level of Memory data structures to `public` as part of
new `Plugins.Memory` project (so they are accessible by tests and users
if needed).
6. Added ADR,

### Contribution Checklist

<!-- Before submitting this PR, please make sure: -->

- [x] The code builds clean without any errors or warnings
- [x] The PR follows the [SK Contribution
Guidelines](https://github.com/microsoft/semantic-kernel/blob/main/CONTRIBUTING.md)
and the [pre-submission formatting
script](https://github.com/microsoft/semantic-kernel/blob/main/CONTRIBUTING.md#development-scripts)
raises no violations
- [x] All unit tests pass, and I have added new tests where possible
- [ ] I didn't break anyone :smile:
- This PR contains breaking changes as namespaces for several
Memory-related classes were changed according to new project location.

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
