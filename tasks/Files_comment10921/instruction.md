# Code Review Task

You are a maintainer reviewing a pull request to the `files-community/Files` repository.

**PR title:** Feature: Added option to pin recycle bin to the start menu

**PR description:**

<!-- 
🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨
I ACKNOWLEDGE THE FOLLOWING BEFORE PROCEEDING:
1. PR may be deleted if it is not following the template
2. Try not to make duplicates. Do a quick search before posting
3. Add a clear title starting with "Feature:" or "Fix:"
-->

**Resolved / Related Issues**
Items resolved / related issues by this PR.
- Closes #issue #6230

**Validation**
How did you test these changes?
- [X] Built and ran the app
- [x] Tested the changes for accessibility

**Screenshots (optional)**
Add screenshots here.
![image](https://user-images.githubusercontent.com/91097852/210514289-7771ed87-33da-4778-a163-b2827dd1830c.png)
![image](https://user-images.githubusercontent.com/91097852/210514384-4d513e8c-c3de-4746-9d9c-8a4addaff8d0.png)

## Working environment

The repository is checked out at `/app/Files` at this PR's **base commit**
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
