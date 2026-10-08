# Code Review Task

You are a maintainer reviewing a pull request to the `immich-app/immich` repository.

**PR title:** ci: more path filtering, path filtering happens in pre-job so all jobs can be required

**PR description:**

This PR moves our path filtering from the github workflow path filtering to a pre-job. This allows us to have more flexibility on filtering specific jobs with path filtering, as well as meaning skipped jobs will show as a success, allowing us to require all jobs on all PRs.

Additional path filters added in this PR:
- build-mobile now path filters on mobile/**
- docker builds were split into machine-learning and server, now have path filtering for those builds (steps were duplicated as no easy way to de-duplicate that right now, worth it for the saved runner concurrency imo)
- static-analysis now path filters on mobile/**
- tests now path filter on a range of different paths depending on the job

This should massively reduce our job concurrency and for small PRs just touching specific sub-sections of the codebase, should massively reduce the time waiting for jobs to complete :smile_cat:

## Working environment

The repository is checked out at `/app/immich` at this PR's **base commit**
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
