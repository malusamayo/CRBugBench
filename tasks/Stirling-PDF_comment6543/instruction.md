# Code Review Task

You are a maintainer reviewing a pull request to the `Stirling-Tools/Stirling-PDF` repository.

**PR title:** Add new triggers, sources and sinks to policies

**PR description:**

# Description of Changes
Add new triggers:
- Schedule (fires every X amount of time)
- Folder watch (fires whenever the OS tells us a folder has a new file in it; on Mac this is technically a 2s schedule but that's just how Java implements it)

Add new sources:
- Folder (reads from this directory)

Add new sinks:
- Inline (stores in FileStorage)
- Folder (stores in specified directory)

Still want to do S3 buckets and web hooks and stuff, but they can come in a future PR. I'm hoping this should make it sufficient to be able to integrate with processing folders frontend etc. I've also changed it so that policies can have multiple sources and triggers at once, which seems like it might be useful.

## Working environment

The repository is checked out at `/app/Stirling-PDF` at this PR's **base commit**
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
