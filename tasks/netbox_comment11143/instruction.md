# Code Review Task

You are a maintainer reviewing a pull request to the `netbox-community/netbox` repository.

**PR title:** 11077 use formatting for custom field date

**PR description:**

<!--
    Thank you for your interest in contributing to NetBox! Please note that
    our contribution policy requires that a feature request or bug report be
    approved and assigned prior to opening a pull request. This helps avoid
    waste time and effort on a proposed change that we might not be able to
    accept.

    IF YOUR PULL REQUEST DOES NOT REFERENCE AN ISSUE WHICH HAS BEEN ASSIGNED
    TO YOU, IT WILL BE CLOSED AUTOMATICALLY.

    Please specify your assigned issue number on the line below.
-->
### Fixes: #11077 

<!--
    Please include a summary of the proposed changes below.
-->
Updates custom field display in tables to use SHORT_DATE_FORMAT specifier, also updates the override for DateColumn to also use SHORT_DATE_FORMAT. Is assuming Custom field date will always be in the Y-m-d format, would need an extra date-format specifier if in another format.

## Working environment

The repository is checked out at `/app/netbox` at this PR's **base commit**
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
