# Code Review Task

You are a maintainer reviewing a pull request to the `bitwarden/server` repository.

**PR title:** SM-1012: Removing SM Beta (Phase 2)

**PR description:**

## Type of change

<!-- (mark with an `X`) -->

```
- [ ] Bug fix
- [ ] New feature development
- [x] Tech debt (refactoring, code cleanup, dependency upgrades, etc)
- [ ] Build/deploy pipeline (DevOps)
- [ ] Other
```

## Objective
<!--Describe what the purpose of this PR is. For example: what bug you're fixing or what new feature you're adding-->

Now that phase 1 of SM beta is complete, in phase 2 we remove all references to SecretsManagerBeta in the server project, but leave the references in the db for phase 3. We need to do this to ensure compatibility between the current and previous versions of server with the database.

## Before you submit

- Please check for formatting errors (`dotnet format --verify-no-changes`) (required)
- If making database changes - make sure you also update Entity Framework queries and/or migrations
- Please add **unit tests** where it makes sense to do so (encouraged but not required)
- If this change requires a **documentation update** - notify the documentation team
- If this change has particular **deployment requirements** - notify the DevOps team

## Working environment

The repository is checked out at `/app/server` at this PR's **base commit**
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
