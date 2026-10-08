# Code Review Task

You are a maintainer reviewing a pull request to the `supabase/supabase` repository.

**PR title:** Chore/update shared snippet warning

**PR description:**

![screenshot-2024-06-17-at-22 06 06](https://github.com/supabase/supabase/assets/105593/8eeab354-8574-4f27-b8fc-da0cd6ba7de1)


Updates messaging on the share modal:
![screenshot-2023-10-02-at-14 22 38](https://github.com/supabase/supabase/assets/105593/5846ae33-f445-43c9-ba89-484a76c04a4d)


 
Adds a read-only badge if you're trying to save a snippet that you don't own:
![screenshot-2023-09-29-at-17 10 03](https://github.com/supabase/supabase/assets/105593/e1377134-f644-41d7-a545-aac7ddbd3a95)

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
