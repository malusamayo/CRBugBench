# Code Review Task

You are a maintainer reviewing a pull request to the `mitmproxy/mitmproxy` repository.

**PR title:** Save filtered button

**PR description:**

Add "Save filtered" to mitmweb (backend: optional arg + js: added handler)
Use conexts in backend instead of manually closing
Transfer dumps gzipped instead of plain for speedup
Change Save... to Save, as there is no ...

#### Description

![image](https://user-images.githubusercontent.com/9084941/184683599-4c38c33b-2f6f-4b12-b8e4-e6e8e2841ca0.png)

#### Checklist

 - [x] I have updated tests where applicable.
 - [x] I have added an entry to the CHANGELOG.

## Working environment

The repository is checked out at `/app/mitmproxy` at this PR's **base commit**
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
