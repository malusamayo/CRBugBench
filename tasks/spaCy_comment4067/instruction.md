# Code Review Task

You are a maintainer reviewing a pull request to the `explosion/spaCy` repository.

**PR title:** Update gold corpus code to properly ingest a directory of jsonlines f…

**PR description:**

Add change to allow the cli training code to ingest from a directory of jsonlines files.

In response to: https://github.com/explosion/spaCy/issues/3975


## Description
Add change to allow the cli training code to ingest from a directory of jsonlines files.


### Types of change
minor bug fix

## Checklist
<!--- Before you submit the PR, go over this checklist and make sure you can
tick off all the boxes. [] -> [x] -->
- [x ] I have submitted the spaCy Contributor Agreement.
- [ ] I ran the tests, and all new and existing tests passed.
- [x ] My changes don't require a change to the documentation, or if they do, I've added all required information.

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
