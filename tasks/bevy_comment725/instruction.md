# Code Review Task

You are a maintainer reviewing a pull request to the `bevyengine/bevy` repository.

**PR title:** fix wavy text

**PR description:**

Addresses #283 

Quick fix for wavy text.

You can see the difference in the "ing" in "Nothing".

Before  
![image](https://user-images.githubusercontent.com/38416468/97081682-95ab2b00-1636-11eb-8502-156415e6cbb6.png)

After  
![image](https://user-images.githubusercontent.com/38416468/97081667-78765c80-1636-11eb-8d11-09e1a1411be4.png)

Here is what it looks like in Word for reference:
![image](https://user-images.githubusercontent.com/38416468/97081771-36014f80-1637-11eb-90db-c5823ea443fb.png)

## Working environment

The repository is checked out at `/app/bevy` at this PR's **base commit**
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
