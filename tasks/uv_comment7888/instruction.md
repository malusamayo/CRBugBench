# Code Review Task

You are a maintainer reviewing a pull request to the `astral-sh/uv` repository.

**PR title:** Add shellcheck CI

**PR description:**

<!--
Thank you for contributing to uv! To help us out with reviewing, please consider the following:

- Does this pull request include a summary of the change? (See below.)
- Does this pull request include a descriptive title?
- Does this pull request include references to any relevant issues?
-->

## Summary

I started learning `uv` by inspecting the source code.
I've noticed that your shell scripts are very good! Which is rare!

## Test Plan

I propose to add `shellcheck` to the CI.
It is a great tool to help finding bugs and style issues in shell code.

Techincal details:
- This CI job will only run when any `.sh` files are changed (or the job definition file)
- It takes just several seconds even on local machine:
```
» time shellcheck -S style **/*.sh
shellcheck -S style **/*.sh  0.02s user 0.05s system 61% cpu 0.123 total
```

- It is easy to use, for example: I just fixed the single problem you had in your code with `# shellcheck disable=SC1091`
- I am using this tool for around 8 years now and didn't have any issues. Examples: https://github.com/sobolevn/git-secret/blob/ca899f3b694187f9027161f537414422ee99c483/.github/workflows/test.yml#L22-L27 and https://github.com/wemake-services/wemake-django-template/blob/master/.github/workflows/shellcheck.yml

But, I understand that build / lint tools are very subjective. So, feel free to close :)

## Working environment

The repository is checked out at `/app/uv` at this PR's **base commit**
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
