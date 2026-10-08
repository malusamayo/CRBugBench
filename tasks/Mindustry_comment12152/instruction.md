# Code Review Task

You are a maintainer reviewing a pull request to the `Anuken/Mindustry` repository.

**PR title:** drawNoise/drawNoiseLayers as an effect so that json can use them

**PR description:**

**Example with a datapatch:**

https://github.com/user-attachments/assets/b29e9e9e-ca1a-4c01-b990-c68a1d52b868



If your pull request is **not** translation or serverlist-related, read the list of requirements below and check each box:

- [x] I have read the [contribution guidelines](https://github.com/Anuken/Mindustry/blob/master/CONTRIBUTING.md).
- [x] I have ensured that my code compiles, if applicable.
- [x] I have ensured that any new features in this PR function correctly in-game, if applicable.

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
