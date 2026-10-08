# Code Review Task

You are a maintainer reviewing a pull request to the `rustdesk/rustdesk` repository.

**PR title:** Feat: mobile uni link support (android + ios)

**PR description:**

https://github.com/rustdesk/rustdesk/discussions/4669
Connect to ID using uni/deep link on mobile

Format: `rustdesk://[id]` or `rustdesk://connection/new/[id]` or `rustdesk://connect/[id]` or `rustdesk://play/[id]`
Ex: `rustdesk://13423325234` or `rustdesk://connection/new/13423325234`...

**File transfer:**
Format: `rustdesk://file-transfer/[id]`
Ex: `rustdesk://file-transfer/13423325234`

Works on cold boot as well as when the app is running in the background.


https://github.com/rustdesk/rustdesk/assets/73148455/acc800f1-8e6a-44ee-8f90-937ba6991b6f


https://github.com/rustdesk/rustdesk/assets/73148455/206397fc-e1fb-46df-a19b-128572ae8968

https://github.com/rustdesk/rustdesk/assets/73148455/39148305-58e1-48f0-93f4-ce449bdba0ab

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
