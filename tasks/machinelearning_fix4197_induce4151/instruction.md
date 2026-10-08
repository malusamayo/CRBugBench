# Code Review Task

You are a maintainer reviewing a pull request to the `dotnet/machinelearning` repository.

**PR title:** Image classification preview 2. (#4151)

**PR description / commit message:**

Image classification preview 2. (#4151)

* Image classification preview 2.

* PR feedback.

* Add unit-test.

* Add unit-test.

* Add unit-test.

* Add unit-test.

* Use Path.Combine instead of Join.

* fix test dataset path.

* fix test dataset path.

* Improve test.

* Improve test.

* Increase epochs in tests.

* Disable test on Ubuntu.

* Move test to its own project.

* Move test to its own project.

* Move test to its own project.

* Move test to its own file.

* cleanup.

* Disable parallel execution of tensorflow tests.

* PR feedback.

* PR feedback.

* PR feedback.

* PR feedback.

* Prevent TF test to execute in parallel.

* PR feedback.

* Build error.

* clean up.

## Working environment

The repository is checked out at `/app/machinelearning` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
