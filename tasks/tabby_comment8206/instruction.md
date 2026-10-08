# Code Review Task

You are a maintainer reviewing a pull request to the `Eugeny/tabby` repository.

**PR title:** [feature] add configurable behavior when session ends

**PR description:**

Hi @Eugeny,

This PR adds different tab's behaviors on session ending.
As asked in #6617, #7751 and #8062, you can choose to keep the tab opened after you got disconnected or exited the shell. You can also choose to automatically reconnect the session or close the tab.

![image](https://user-images.githubusercontent.com/20025949/231595388-1d628abd-a064-4186-bb2f-abe7428775f3.png)

I didn't add the ability to configure this feature independently on each profile, but i can definitely take a look if you think it could be useful.

Feel free to ask if any changes are required.

## Working environment

The repository is checked out at `/app/tabby` at this PR's **base commit**
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
