# Code Review Task

You are a maintainer reviewing a pull request to the `supabase/supabase` repository.

**PR title:** docs: use createResource instead of signal+effect

**PR description:**

## What kind of change does this PR introduce?

Replace bad practice way of fetching data in the example. Ideally It’d be a solidstart `server$` function, but for solid this is the way.

## What is the current behavior?

Using signal + effect, very react-inspired.

## What is the new behavior?

Using createResource, a much more ergonomic API and easier to understand.

## Working environment

The repository is checked out at `/app/supabase` at this PR's **base commit**
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
