# Code Review Task

You are a maintainer reviewing a pull request to the `gitextensions/gitextensions` repository.

**PR title:** fix(File History): Do not change capitalization of filename

**PR description:**

Fixes #11886

## Proposed changes

- fix(FileHistory): Do not change the capitalization of filename passed on the command line
  because the filename filter of "git log" is case-sensitive
  rather keep the existing path, which has the correct capitalization if the File History is invoked by GE

## Screenshots <!-- Remove this section if PR does not change UI -->

### Before

![image](https://github.com/user-attachments/assets/c74f53b0-537f-4056-87a8-614874d6f143)

### After

![image](https://github.com/user-attachments/assets/704e85a2-d53a-473f-9e0d-7cfc1af24007)

## Test methodology <!-- How did you ensure quality? -->

- manual

## Merge strategy

<!-- Change the following if the merge strategy should be changed:
- Squash merge (maintainer to decide merge message, PR submitter should cleanup commits/messages at PR approval).
- Rebase merge (PR submitter must change the commit message for the last commit).
- Merge commit. (PR submitter to rebase and squash before merges).
- To be decided later.
The maintainer may still request the contributor to squash and rebase, to make sure that merges and commit messages are clarified.
-->

I agree that the maintainer squash merge this PR (if the commit message is clear).

----

:black_nib: I contribute this code under [The Developer Certificate of Origin](../blob/master/contributors.txt).

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
