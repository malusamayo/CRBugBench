# Code Review Task

You are a maintainer reviewing a pull request to the `Anuken/Mindustry` repository.

**PR title:** Map search

**PR description:**

Add map search to the map dialog. Also add a filter menu to filter maps by game mode, as well as to hide/show default maps in the map dialog. 

Figured i might as well add this since #2080 seems dormant. Since the entire search bar and filter button is a slim line it shouldn't cause too many issues with mobile landscape vertical space.

Demo:

https://user-images.githubusercontent.com/62061444/133461475-0ba7cea5-6bd7-4fed-9006-44ff5bb430fc.mp4

---

If your pull request is **not** translation or serverlist-related, read the list of requirements below and check each box:

- [X] I have read the [contribution guidelines](https://github.com/Anuken/Mindustry/blob/master/CONTRIBUTING.md).
- [X] I have ensured that my code compiles, if applicable.
- [X] I have ensured that any new features in this PR function correctly in-game, if applicable.

## Working environment

The repository is checked out at `/app/Mindustry` at this PR's **base commit**
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
