# Code Review Task

You are a maintainer reviewing a pull request to the `yt-dlp/yt-dlp` repository.

**PR title:** Revert default behavior of --cookies-from-browser and firefox

**PR description:**

</details>

<!--

Explanation of your *pull request* in arbitrary form goes here. Please **make sure the description explains the purpose and effect** of your *pull request* and is worded well enough to be understood. Provide as much **context and examples** as possible

-->

Reverts default behavior of `--cookies-from-browser` and firefox containers to what it was before 9bd13fe

 - `--cookies-from-browser firefox` will load all cookies from all containers and those not belonging to any container
 - `--cookies-from-browser firefox:PROFILE:CONTAINER` will load cookies only from the container name specified as `CONTAINER`
 - `--cookies-from-browser firefox:PROFILE:none` will only load cookies not belonging to any container
 
`PROFILE` may also now be left empty when specifying a container, e.g:
- `--cookies-from-browser firefox::none` will load cookies not belonging to any container from the most recently used profile
- `--cookies-from-browser firefox::` behaves the same as `--cookies-from-browser firefox`

Fixes #4800 


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
- [x] Checked the code with [flake8](https://pypi.python.org/pypi/flake8) and [ran relevant tests](https://github.com/yt-dlp/yt-dlp/blob/master/CONTRIBUTING.md#developer-instructions)

### In order to be accepted and merged into yt-dlp each piece of code must be in public domain or released under [Unlicense](http://unlicense.org/). Check one of the following options:
- [x] I am the original author of this code and I am willing to release it under [Unlicense](http://unlicense.org/)
- [ ] I am not the original author of this code but it is in public domain or released under [Unlicense](http://unlicense.org/) (provide reliable evidence)

### What is the purpose of your *pull request*?
- [ ] Fix or improvement to an extractor (Make sure to add/update tests)
- [ ] New extractor ([Piracy websites will not be accepted](https://github.com/yt-dlp/yt-dlp/blob/master/CONTRIBUTING.md#is-the-website-primarily-used-for-piracy))
- [x] Core bug fix/improvement
- [ ] New feature (It is strongly [recommended to open an issue first](https://github.com/yt-dlp/yt-dlp/blob/master/CONTRIBUTING.md#adding-new-feature-or-making-overarching-changes))

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
