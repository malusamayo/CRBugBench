# Code Review Task

You are a maintainer reviewing a pull request to the `meilisearch/meilisearch` repository.

**PR title:** Parallelize bulk facets & word prefix fid/position docids

**PR description:**

This fixes #5290, and it will probably be followed by another PR to work on the incremental part of it. A prototype is available, called `prototype-speedup-post-processing-2`.

I replicated a dataset of about 30M documents to see how it behaves, and we can clearly see that the timings are divided by even more than the number of CPUs (4 in this case) and are closer to being divided by 6. Which is absolutely great 🎉 Both list of batches are linked below.

As a reviewer, you must know that you have to review the algorithms in this PR but also [the PR that modifies LMDB](https://github.com/meilisearch/lmdb/pull/3) to implement the feature to be able to read uncommitted changes from multiple threads (creating nested transactions).

[batches-original.json](https://github.com/user-attachments/files/22594032/gethookd.json)
[batches-replicated.json](https://github.com/user-attachments/files/22594038/gethookd-replicated.json)

### To Do
- [x] Use heed@0.22.1-nested-rtxns.
  - [x] In hannoy.
  - [x] In arroy.
  - [x] In Cellulite.
- [x] Introduce two experimental CLI arguments to disable the post-processing of prefixes and facets.
- [x] (will be done) [Disable it by default on the Cloud](https://linear.app/meilisearch/issue/SCA-236/disable-it-by-default-on-the-cloud).
- [ ] ~Create a follow-up PR for the incremental part~.
- [x] Create [a follow-up PR](https://linear.app/meilisearch/issue/SCA-237/fix-ghost-doc-ids-in-prefixes-with-single-threaded-prefix-post) to fix the bug in the non-multithreaded version.
- [x] Review the facet bulk implementation.
- [x] Test on big customers who seek fast word prefix docids.
- [x] Use env var `MEILI_TEST_FULL_SNAPS` to see the real snap content.

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
