# Code Review Task

You are a maintainer reviewing a pull request to the `n8n-io/n8n` repository.

**PR title:** fix(AI Agent Node): Allow removal of system message

**PR description:**

## Summary
Removes the default system message that is passed when using ToolsAgent if no system message was setup by the user. Only happens for newest node version.
This should prevent blocking models like o1-mini that don't support system messages.
<!--
Describe what the PR does and how to test.
Photos and videos are recommended.
-->

## Related Linear tickets, Github issues, and Community forum posts

<!--
Include links to **Linear ticket** or Github issue or Community forum post.
Important in order to close *automatically* and provide context to reviewers.
-->
<!-- Use "closes #<issue-number>", "fixes #<issue-number>", or "resolves #<issue-number>" to automatically close issues when the PR is merged. -->
fixes #13710 

## Review / Merge checklist

- [x] PR title and summary are descriptive. ([conventions](../blob/master/.github/pull_request_title_conventions.md)) <!--
   **Remember, the title automatically goes into the changelog.
   Use `(no-changelog)` otherwise.**
-->
- [ ] [Docs updated](https://github.com/n8n-io/n8n-docs) or follow-up ticket created.
- [x] Tests included. <!--
   A bug is not considered fixed, unless a test is added to prevent it from happening again.
   A feature is not complete without tests.
-->
- [ ] PR Labeled with `release/backport` (if the PR is an urgent fix that needs to be backported)

## Working environment

The repository is checked out at `/app/n8n` at this PR's **base commit**
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
