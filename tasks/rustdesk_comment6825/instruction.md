# Code Review Task

You are a maintainer reviewing a pull request to the `rustdesk/rustdesk` repository.

**PR title:** Feat: Windows connect to a specific user session

**PR description:**

#2095
#323 related but no concurrent user sessions

Note: Both client and server-side needs to be updated. Also, installation is required.

---
Test:
RDPWrapper's RDPCheck program running on user `sahil_2` while the default (console) is the user `Sahil`.
I don't have a setup for terminal sessions so I haven't tested that. Feedback would be appreciated.


https://github.com/rustdesk/rustdesk/assets/73148455/ace53c41-7bb5-4ab2-84e1-8e0856609d7e

Tested mac, android -> windows too

---
Workflow:
![image](https://github.com/rustdesk/rustdesk/assets/73148455/9aa9afb2-9126-4484-85da-aaa66eb7df9c)

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
