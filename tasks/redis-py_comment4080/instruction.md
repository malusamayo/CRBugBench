# Code Review Task

You are a maintainer reviewing a pull request to the `redis/redis-py` repository.

**PR title:** ci: least-privilege permissions on spellcheck (read) and stale-issues (job-level write for actions/stale)

**PR description:**

Pins the default `GITHUB_TOKEN` to `contents: read` at workflow level for two workflows, then re-grants the writes needed by `actions/stale` at the job level so behavior is unchanged.

**spellcheck.yml** - read-only, no GitHub API writes; workflow-level `contents: read` is sufficient.

**stale-issues.yml** - the `stale` job uses `actions/stale@v10`, which needs `issues: write` and `pull-requests: write` to label and close stale items. Re-granted at the job level only; the workflow default stays `contents: read`. (Thanks to @petyaslavova for catching the missing description and to the cursor review for flagging that the stale action would break without writes.)

Post-CVE-2025-30066 hardening pattern: declare a least-privilege default and elevate per job only where needed.

<!-- CURSOR_SUMMARY -->
---

> [!NOTE]
> **Low Risk**
> Workflow-only permission changes; stale automation keeps the same writes via job-level grants.
> 
> **Overview**
> Tightens **GITHUB_TOKEN** scope on two CI workflows using a least-privilege default plus job-level grants where needed (same pattern as `release-drafter.yml`).
> 
> **`spellcheck.yml`** adds workflow-level `permissions: contents: read` only—checkout and the spelling action need no API writes.
> 
> **`stale-issues.yml`** sets workflow-level `permissions: {}` (no broad defaults) and gives the `stale` job `issues: write`, `pull-requests: write`, and `actions: write` so `actions/stale@v10` can still label/close issues and PRs and use its cache state.
> 
> <sup>Reviewed by [Cursor Bugbot](https://cursor.com/bugbot) for commit 0ceeca5a89682ef086ee8e2492fbb3ce97b11ffd. Bugbot is set up for automated code reviews on this repo. Configure [here](https://www.cursor.com/dashboard/bugbot).</sup>
<!-- /CURSOR_SUMMARY -->

## Working environment

The repository is checked out at `/app/redis-py` at this PR's **base commit**
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
