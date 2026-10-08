# Code Review Task

You are a maintainer reviewing a pull request to the `blakeblackshear/frigate` repository.

**PR title:** Fixes

**PR description:**

## Proposed change
<!--
  Describe what this pull request does and how it will benefit users of Frigate.
  Please describe in detail any considerations, breaking changes, etc. that are 
  made in this pull request.
-->

- Fix handling when single event is deleted
- Fix infinite loop for overlay state

## Type of change

- [ ] Dependency upgrade
- [x] Bugfix (non-breaking change which fixes an issue)
- [ ] New feature
- [ ] Breaking change (fix/feature causing existing functionality to break)
- [ ] Code quality improvements to existing code
- [ ] Documentation Update

## Additional information

- This PR fixes or closes issue: fixes #
- This PR is related to issue: 

## Checklist

<!--
  Put an `x` in the boxes that apply.
-->

- [x] The code change is tested and works locally.
- [x] Local tests pass. **Your PR cannot be merged unless tests pass**
- [x] There is no commented out code in this PR.
- [x] The code has been formatted using Ruff (`ruff format frigate`)

## Working environment

The repository is checked out at `/app/frigate` at this PR's **base commit**
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
