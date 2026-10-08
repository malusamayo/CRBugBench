# Code Review Task

You are a maintainer reviewing a pull request to the `langgenius/dify` repository.

**PR title:** Optimize db config

**PR description:**

# Checklist:

> [!IMPORTANT]  
> Please review the checklist below before submitting your pull request.

- [x] Please open an issue before creating a PR or link to an existing issue
- [x] I have performed a self-review of my own code
- [x] I have commented my code, particularly in hard-to-understand areas
- [x] I ran `dev/reformat`(backend) and `cd web && npx lint-staged`(frontend) to appease the lint gods

# Description

1. support [sqlalchemy debug mode](https://docs.sqlalchemy.org/en/20/core/engines.html#sqlalchemy.create_engine.params.echo)
2. replace `DB_CHARSET` config with `DB_EXTRAS` which is more flexible.


Fixes https://github.com/langgenius/dify/issues/5639

## Type of Change

- [x] Bug fix (non-breaking change which fixes an issue)
- [ ] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] This change requires a documentation update, included: [Dify Document](https://github.com/langgenius/dify-docs)
- [ ] Improvement, including but not limited to code refactoring, performance optimization, and UI/UX improvement
- [ ] Dependency upgrade

# Testing Instructions

Please describe the tests that you ran to verify your changes. Provide instructions so we can reproduce. Please also list any relevant details for your test configuration

- [ ] Test A
- [ ] Test B

## Working environment

The repository is checked out at `/app/dify` at this PR's **base commit**
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
