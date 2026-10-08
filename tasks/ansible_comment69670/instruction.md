# Code Review Task

You are a maintainer reviewing a pull request to the `ansible/ansible` repository.

**PR title:** Make connection plugins use password from config

**PR description:**

##### SUMMARY

Change:
Rather than connection plugins directly accessing play_context and pulling
the password from there, have them pull it from the config system, and
have TaskExecutor store it there for now.

Internally, it still routes through play_context for now, but this is
the first step away from that.

Test Plan:
- Local test with `ansible -c ssh`
- grep -R play_context.pass lib/ansible/plugins/connection/
- CI



<!--- Describe the change below, including rationale and design decisions -->

<!--- HINT: Include "Fixes #nnn" if you are fixing an existing issue -->

##### ISSUE TYPE
<!--- Pick one below and delete the rest -->
- Bugfix Pull Request

##### COMPONENT NAME

connection, task_executor

## Working environment

The repository is checked out at `/app/ansible` at this PR's **base commit**
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
