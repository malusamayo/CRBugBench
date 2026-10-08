# Code Review Task

You are a maintainer reviewing a pull request to the `servo/servo` repository.

**PR title:** Added fetch_start functionality

**PR description:**

<!-- Please describe your changes on the following line: -->
Added the fetch_start functionality in http_loader.rs (http_fetch function)

---
<!-- Thank you for contributing to Servo! Please replace each `[ ]` by `[X]` when the step is complete, and replace `___` with appropriate data: -->
- [X] `./mach build -d` does not report any errors
- [X] `./mach test-tidy` does not report any errors
- [X] These changes fix #21258 (GitHub issue number if applicable)

<!-- Either: -->
- [X] There are tests for these changes OR
- [ ] These changes do not require tests because ___

<!-- Also, please make sure that "Allow edits from maintainers" checkbox is checked, so that we can help you if you get stuck somewhere along the way.-->

<!-- Pull requests that do not address these steps are welcome, but they will require additional verification as part of the review process. -->

<!-- Reviewable:start -->
---
This change is [<img src="https://reviewable.io/review_button.svg" height="34" align="absmiddle" alt="Reviewable"/>](https://reviewable.io/reviews/servo/servo/22714)
<!-- Reviewable:end -->

## Working environment

The repository is checked out at `/app/servo` at this PR's **base commit**
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
