# Code Review Task

You are a maintainer reviewing a pull request to the `explosion/spaCy` repository.

**PR title:** spaCy v3 is not saving the best version in training loop

**PR description:**

## Description

During a training session using the latest spaCy v3 I realized that it was not saving the "best" version during training, it was saving only the latest. 
After a debug I found the error. During the training loop the check condition for is_best_checkpoint was wrong. I also realized that it was always saving the optimizer average, and also put a condition to check this. 

### Types of change
It is a bugfix to the training loop

## Checklist
<!--- Before you submit the PR, go over this checklist and make sure you can
tick off all the boxes. [] -> [x] -->
- [X] I have submitted the spaCy Contributor Agreement.
- [X] I ran the tests, and all new and existing tests passed.
- [X] My changes don't require a change to the documentation, or if they do, I've added all required information.

## Working environment

The repository is checked out at `/app/spaCy` at this PR's **base commit**
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
