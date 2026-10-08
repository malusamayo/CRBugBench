# Code Review Task

You are a maintainer reviewing a pull request to the `meilisearch/meilisearch` repository.

**PR title:** Update nbHits count with filtered documents

**PR description:**

Closes #764 
close #1039

After discussing with @MarinPostma on Slack, this is my first attempt at implementing this for the basic flow that will go through `bucket_sort_with_distinct`.

A few thoughts here: 

- For getting the count of filtered documents alone, I originally thought of using `filter_map.values().filter(|&&v| !v).count()`. In a few cases, this was the same as what I have now implemented. But I realised I couldn't do something similar for `distinct`. So for being consistent, I have implemented both in a similar fashion.
- I also needed the `contains_key` check to ensure we're not counting the same document ID twice.

@MarinPostma also mentioned that this will be an approximation since the sort is lazy. In the test example that I've updated, the actual filtered count will be just 19 (for `male` records), but due to the `limit` in play, it returns 32 (filtering out 11 records overall).

Please let me know if this is the kind of fix we are looking for, and I can implement it in the placeholder search also.

## Working environment

The repository is checked out at `/app/meilisearch` at this PR's **base commit**
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
