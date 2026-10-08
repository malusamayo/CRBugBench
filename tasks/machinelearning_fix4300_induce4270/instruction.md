# Code Review Task

You are a maintainer reviewing a pull request to the `dotnet/machinelearning` repository.

**PR title:** Modified the project to support running of TensorFlow on GPU on Windows. (#4270)

**PR description / commit message:**

Modified the project to support running of TensorFlow on GPU on Windows. (#4270)

* Modified the project to support running of TensorFlow on GPU on Windows.

Removed all dependencies of TensorFlow redist from the source projects,
and instead added the dependency to the Sample project.
Created separate sample project for GPU examples since gpu tensorflow requires cuda,
which may not be available on all machines, so it needs to be a separate
project.
Added documentation for setup as there is now some requirements.

* Added NuGet dependency to the test packages which need TensorFlow.

* Changed to use the Dependency variable for the TF version.

* removed erronious newlines.

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
