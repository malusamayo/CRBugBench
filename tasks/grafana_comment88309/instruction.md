# Code Review Task

You are a maintainer reviewing a pull request to the `grafana/grafana` repository.

**PR title:** Alerting: Scheduled recording rules execute their queries

**PR description:**

**What is this feature?**

Extends the recording rule shim to execute the query defined in the rule.

Right now it does nothing with the results other than log them. Queries look like alert rule queries, metrics update accordingly. This is skipped if the feature toggle is disabled.

**Which issue(s) does this PR fix?**:

n/a

**Special notes for your reviewer:**

Please check that:
- [x] It works as expected from a user's perspective.
- [x] If this is a pre-GA feature, it is behind a feature toggle.
- [x] The docs are updated, and if this is a [notable improvement](https://grafana.com/docs/writers-toolkit/writing-guide/contribute-release-notes/#how-to-determine-if-content-belongs-in-a-whats-new-document), it's added to our [What's New](https://grafana.com/docs/writers-toolkit/writing-guide/contribute-release-notes/) doc.

## Working environment

The repository is checked out at `/app/grafana` at this PR's **base commit**
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
