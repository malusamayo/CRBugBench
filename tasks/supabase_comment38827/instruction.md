# Code Review Task

You are a maintainer reviewing a pull request to the `supabase/supabase` repository.

**PR title:** feat(docs): add menu links to Supabase UI Library

**PR description:**

## What kind of change does this PR introduce?

feature, docs update

## What is the current behavior?

Currently the [docs](https://supabase.com/docs) site don't have quick links that reference [Supabase UI](https://supabase.com/ui).

## What is the new behavior?

This PR brings more visibility to [Supabase UI](https://supabase.com/ui) by adding some menu links to it.

## Additional context

<details>
<summary>Visual changes</summary>

#### Reference menu
<img width="1302" height="720" alt="image" src="https://github.com/user-attachments/assets/9284305a-e7da-4b88-bd43-b26dc7b816db" />

#### Additional resources section
<img width="1303" height="730" alt="image" src="https://github.com/user-attachments/assets/fb998ebf-202e-4aed-adbc-6122d3eabd89" />

#### "Go to" command
<img width="1122" height="705" alt="image" src="https://github.com/user-attachments/assets/e186dbce-06f4-48d3-b7c7-93b4efd17621" />


</details>

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
