# Code Review Task

You are a maintainer reviewing a pull request to the `yt-dlp/yt-dlp` repository.

**PR title:** [ie/bilibili] Provide fallback for playinfo extraction

**PR description:**

**IMPORTANT**: PRs without the template will be CLOSED

### Description of your *pull request* and other information

<!--

Explanation of your *pull request* in arbitrary form goes here. Please **make sure the description explains the purpose and effect** of your *pull request* and is worded well enough to be understood. Provide as much **context and examples** as possible

-->

[site-bug]
the site has removed `window.__playinfo__` from the page source. This pr adds a fallback by downloading the playinfo from the API on extraction failure and fixes the error handling for member only videos.

Fixes #11665


<details open><summary>Template</summary> <!-- OPEN is intentional -->

<!--

# PLEASE FOLLOW THE GUIDE BELOW

- You will be asked some questions, please read them **carefully** and answer honestly
- Put an `x` into all the boxes `[ ]` relevant to your *pull request* (like [x])
- Use *Preview* tab to see how your *pull request* will actually look like

-->

### Before submitting a *pull request* make sure you have:
- [x] At least skimmed through [contributing guidelines](https://github.com/yt-dlp/yt-dlp/blob/master/CONTRIBUTING.md#developer-instructions) including [yt-dlp coding conventions](https://github.com/yt-dlp/yt-dlp/blob/master/CONTRIBUTING.md#yt-dlp-coding-conventions)
- [x] [Searched](https://github.com/yt-dlp/yt-dlp/search?q=is%3Apr&type=Issues) the bugtracker for similar pull requests

### In order to be accepted and merged into yt-dlp each piece of code must be in public domain or released under [Unlicense](http://unlicense.org/). Check all of the following options that apply:
- [x] I am the original author of this code and I am willing to release it under [Unlicense](http://unlicense.org/)

### What is the purpose of your *pull request*?
- [x] Fix or improvement to an extractor (Make sure to add/update tests)

</details>

## Working environment

The repository is checked out at `/app/yt-dlp` at this PR's **base commit**
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
