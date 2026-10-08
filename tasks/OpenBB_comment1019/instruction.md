# Code Review Task

You are a maintainer reviewing a pull request to the `OpenBB-finance/OpenBB` repository.

**PR title:** Sector and Industry Analysis Improvement

**PR description:**

This PR does the following:
- Improve parameters selection based on what has already been selected, e.g. if the sector is Financial Services, there's no point in showing as industry "Auto Manufacturers. Or if we choose the industry "Asset Management" we know that the sector is "Financial Services"
- Add this logic to the model module so that it speeds up the data retrieval because the loop to run is smaller
- Allows to study companies landscape in terms of companies per country using both sector or industry, and also companies per industry using sector
- Add multiple commands for additional financial stats like PEG, full time employees, market cap, beta, yield, dividend, ...
- Optimize code for these financial stats
- Fix some bugs

## Working environment

The repository is checked out at `/app/OpenBB` at this PR's **base commit**
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
