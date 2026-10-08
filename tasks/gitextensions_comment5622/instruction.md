# Code Review Task

You are a maintainer reviewing a pull request to the `gitextensions/gitextensions` repository.

**PR title:** Issue 5616: Provide a way to remove all invalid recent repositories.

**PR description:**

- Pop up a dialog that asks the user if they want to remove all X invalid repositories whenever the user agrees to removing one invalid repository from the recent repositories drop-down list

Fixes Issue #5616 

Changes proposed in this pull request:
- when the user agrees to remove an invalid repository from the recent repositories drop-down list, pop up a second dialog notifying them the existence of multiple invalid repositories (if they exist).
- if multiple repositories exist, offer the user to remove all of them, in addition to the one that was originally going to be removed from the list

 
Screenshots before and after (if PR changes UI):
- Before:
![first_dialog](https://user-images.githubusercontent.com/14078392/47475447-5d737680-d7e9-11e8-8aed-97097c1b9b68.JPG)


- After:
![first_dialog](https://user-images.githubusercontent.com/14078392/47475447-5d737680-d7e9-11e8-8aed-97097c1b9b68.JPG)

followed by:
![image](https://user-images.githubusercontent.com/14078392/47475445-577d9580-d7e9-11e8-9f18-374f15fc7f42.png)


What did I do to test the code and ensure quality:
- I did interactive testing to ensure that:
- - If the user disagrees with removing _all_ invalid repos from the list, then the first one they agreed to remove will still be removed
- - If the user agrees to remove _all_ invalid repos from the list, all invalid repos are indeed removed from the list
- - If the user does not agree to remove _any_ invalid repos from the list, then the list will remain unchanged

Has been tested on (remove any that don't apply):
- GIT 2.8.1.windows.1
- Windows 10

## Working environment

The repository is checked out at `/app/gitextensions` at this PR's **base commit**
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
