# Code Review Task

You are a maintainer reviewing a pull request to the `jenkinsci/jenkins` repository.

**PR title:** [JENKINS-70729] Rework clouds management into multiple pages (#7658)

**PR description / commit message:**

[JENKINS-70729] Rework clouds management into multiple pages (#7658)

Co-authored-by: Jesse Glick <jglick@cloudbees.com>
Co-authored-by: Daniel Beck <1831569+daniel-beck@users.noreply.github.com>
Co-authored-by: Tim Jacomb <timjacomb1@gmail.com>
Co-authored-by: Tim Jacomb <21194782+timja@users.noreply.github.com>

## Working environment

The repository is checked out at `/app/jenkins` at this PR's **base commit**
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
