# Code Review Task

You are a maintainer reviewing a pull request to the `netbox-community/netbox` repository.

**PR title:** 10902 add location to power feed form

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
### Fixes: #10902 

<!--
    Please include a summary of the proposed changes below.
-->
Adds location field to power feed form and filters rack dropdown based on it:

![Monosnap Add a new power feed | NetBox 2022-11-14 09-38-47](https://user-images.githubusercontent.com/99642/201728526-e372f97f-98b8-4f7f-ac5b-ae053240f194.png)

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
