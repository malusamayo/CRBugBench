# Code Review Task

You are a maintainer reviewing a pull request to the `open-webui/open-webui` repository.

**PR title:** feat: full backend support (including auth/rbac)

**PR description:**

Resolves #68, #281

Auth (backend) will be **REQUIRED** from now on, even for local deployment, just like JupyterLab.

For those who wish to use frontend only for the UI, please check out our stripped down version of ollama-webui forked repo: https://github.com/ollama-webui/ollama-webui-lite

TODO

- [x] migrate DB to sqlite
- [x] require Auth for security
- [x] full multi-user chat history support
- [x] overall code refac
- [x] local indexeddb -> backend db migration guide
- [x] save modelfiles to the backend
- [x] local modelfiles -> backend migration option
- [x] disable modelfiles edit for users
- [x] update backend error page
- [x] whitelist ollama version '0.0.0' (#263)
- [x] doc update
- [x] testing
- [x] **HELP NEEDED**: better doc?

Blockers

- #215

## Working environment

The repository is checked out at `/app/open-webui` at this PR's **base commit**
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
