# Code Review Task

You are a maintainer reviewing a pull request to the `rustdesk/rustdesk` repository.

**PR title:** Allow setting custom server and key with env variables

**PR description:**

1. Code edited to allow the setting of a custom server with env variables

RENDEZVOUS_SERVER1
RENDEZVOUS_SERVER2
RENDEZVOUS_SERVER3

2. Allows editing custom key with 

RS_PUB_KEY_VAL

3. Workflows updated to support adding these custom env variables via secrets.

4. Workflows updated to allow ignoring key signing if specific secrets are set.

5. Interface file checks hbb_common::config::RS_PUB_KEY to decide if to display "run your own server" message rather then the existence of custom-rendezvous-server

6. Added flutter-custom-build.yml so that people can use github workflows to generate there own files using github actions

## Working environment

The repository is checked out at `/app/rustdesk` at this PR's **base commit**
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
