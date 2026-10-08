# Code Review Task

You are a maintainer reviewing a pull request to the `blakeblackshear/frigate` repository.

**PR title:** Embeddings tweaks

**PR description:**

## Proposed change
<!--
  Thank you!

  If you're introducing a new feature or significantly refactoring existing functionality, 
  we encourage you to start a discussion first. This helps ensure your idea aligns with 
  Frigate's development goals.

  Describe what this pull request does and how it will benefit users of Frigate.
  Please describe in detail any considerations, breaking changes, etc. that are 
  made in this pull request.
-->
This PR:
- Makes Semantic Search optional and no longer required to be enabled for GenAI, LPR, and Face Recognition
- Updates the web frontend and stats publishers to reflect only enabled features


## Type of change

- [ ] Dependency upgrade
- [ ] Bugfix (non-breaking change which fixes an issue)
- [ ] New feature
- [ ] Breaking change (fix/feature causing existing functionality to break)
- [x] Code quality improvements to existing code
- [x] Documentation Update

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
