# Code Review Task

You are a maintainer reviewing a pull request to the `jellyfin/jellyfin` repository.

**PR title:** cli: add option to disable network change detection

**PR description:**

<!--
Ensure your title is short, descriptive, and in the imperative mood (Fix X, Change Y, instead of Fixed X, Changed Y).
For a good inspiration of what to write in commit messages and PRs please review https://chris.beams.io/posts/git-commit/ and our documentation.
-->

**Changes**
<!-- Describe your changes here in 1-5 sentences. -->

The NetworkChange API implemented in dotnet is problematic on a lot of platforms. It does not reliably report networking changes and can even cause unhandled exceptions to fail the main thread in extreme cases. Add an option to disable it to allow users to work around the issues caused by this API.

**Issues**
<!-- Tag any issues that this PR solves here.
ex. Fixes # -->

Potentially workarounds #8687, need user testing.

## Working environment

The repository is checked out at `/app/jellyfin` at this PR's **base commit**
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
