# Code Review Task

You are a maintainer reviewing a pull request to the `tensorflow/tfjs` repository.

**PR title:** Lazily instantiate the TextEncoder in platform_browser

**PR description:**

Microsoft IE does not support TextEncoder in browser, so a workaround is needed to ensure it doesn't break tests which implement multiple browsers.

To see the logs from the Cloud Build CI, please join either our [discussion](https://groups.google.com/a/tensorflow.org/forum/#!forum/tfjs) or [announcement](https://groups.google.com/a/tensorflow.org/forum/#!forum/tfjs-announce) mailing list.

<!-- Reviewable:start -->
---
This change is [<img src="https://reviewable.io/review_button.svg" height="34" align="absmiddle" alt="Reviewable"/>](https://reviewable.io/reviews/tensorflow/tfjs/2032)
<!-- Reviewable:end -->

## Working environment

The repository is checked out at `/app/tfjs` at this PR's **base commit**
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
