# Code Review Task

You are a maintainer reviewing a pull request to the `bisq-network/bisq` repository.

**PR title:** Gui layout tweaks

**PR description:**

Initiated by a recent issue I went ahead and streamlined a few list views in the Bisq GUI. Please enjoy the before/after shots below:
![Screenshot from 2019-08-13 11-21-30](https://user-images.githubusercontent.com/1070734/62936988-83472780-bdcb-11e9-9a21-a4f611f8525c.png)
![Screenshot from 2019-08-13 11-41-07](https://user-images.githubusercontent.com/1070734/62937119-f2248080-bdcb-11e9-84b0-08d26737f426.png)

closes #3014

## Working environment

The repository is checked out at `/app/bisq` at this PR's **base commit**
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
