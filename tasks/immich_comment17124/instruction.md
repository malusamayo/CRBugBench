# Code Review Task

You are a maintainer reviewing a pull request to the `immich-app/immich` repository.

**PR title:** feat: improve performance for GET /api/album & /api/album/:id 

**PR description:**

## Description

Performance improvement for GET /api/albums when there are >10K assets in multiple albums

This is a significant UX improvment for first load page performance and repeated navigation into and out of albums (depending on browser caching)

### Query Times
Average BEFORE 1.78s 
Average AFTER 0.67s
Difference -1.11s

Improvement 62.3%

From:
![image](https://github.com/user-attachments/assets/3b776af7-d564-4fbd-94c1-cbc961252e53)

To:
![image](https://github.com/user-attachments/assets/a188e95e-5b4d-4178-8b4e-d304e7cdcef1)
Fixes # (issue)

## How Has This Been Tested?

Find a server with albums at least 2-3 albums with over 30k assets in each

Remember to disable browser cache just in case
![image](https://github.com/user-attachments/assets/bfa53cf2-4414-410c-a571-3323e48a521b)

- [x] Load the albums page, go into album page, come back. There should be a noticable reduction in lag

## Checklist:

- [x] I have performed a self-review of my own code
- [x] I have made corresponding changes to the documentation if applicable
- [x] I have no unrelated changes in the PR.
- [x] I have confirmed that any new dependencies are strictly necessary.
- [x] I have written tests for new code (if applicable)
- [x] I have followed naming conventions/patterns in the surrounding code
- [x] All code in `src/services/` uses repositories implementations for database calls, filesystem operations, etc.
- [x] All code in `src/repositories/` is pretty basic/simple and does not have any immich specific logic (that belongs in `src/services/`)

Thanks to @mertalev for helping with more indepth analysis of SQL queries! :)

## Working environment

The repository is checked out at `/app/immich` at this PR's **base commit**
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
