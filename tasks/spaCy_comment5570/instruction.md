# Code Review Task

You are a maintainer reviewing a pull request to the `explosion/spaCy` repository.

**PR title:** Add "c'mon" token exception

**PR description:**

<!--- Provide a general summary of your changes in the title. -->

## Description
<!--- Use this section to describe your changes. If your changes required
testing, include information about the testing environment and the tests you
ran. If your test fixes a bug reported in an issue, don't forget to include the
issue number. If your PR is still a work in progress, that's totally fine – just
include a note to let us know. -->

### Types of change
<!-- What type of change does your PR cover? Is it a bug fix, an enhancement
or new feature, or a change to the documentation? -->
Enhancement

## Checklist
<!--- Before you submit the PR, go over this checklist and make sure you can
tick off all the boxes. [] -> [x] -->
- [x] I have submitted the spaCy Contributor Agreement.
- [x] I ran the tests, and all new and existing tests passed.
- [x] My changes don't require a change to the documentation, or if they do, I've added all required information.

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
