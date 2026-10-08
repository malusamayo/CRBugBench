# Code Review Task

You are a maintainer reviewing a pull request to the `firecracker-microvm/firecracker` repository.

**PR title:** fix: logic to detect changed files 

**PR description:**

## Changes:
- In non PR context, return empty list for changed files.
- In PR context, use $BUILDKITE_PULL_REQUEST_BASE_BRANCH if available
  or else "main" as the base branch to check for list of files
  changed.

## Reason:
- For custom buildkite jobs or nightly tests the concept of changed
  files is not valid.
- When PR's are raised on release branches, comparing changed files
  against main leads to running unnecessary tests like buid_devctr
  even when there is no Dockerfile change in the release branch.


## License Acceptance

By submitting this pull request, I confirm that my contribution is made under
the terms of the Apache 2.0 license. For more information on following Developer
Certificate of Origin and signing off your commits, please check
[`CONTRIBUTING.md`][3].

## PR Checklist

- [ ] If a specific issue led to this PR, this PR closes the issue.
- [x] The description of changes is clear and encompassing.
- [x] Any required documentation changes (code and docs) are included in this
  PR.
- [ ] API changes follow the [Runbook for Firecracker API changes][2].
- [ ] User-facing changes are mentioned in `CHANGELOG.md`.
- [x] All added/changed functionality is tested.
- [ ] New `TODO`s link to an issue.
- [x] Commits meet
  [contribution quality standards](https://github.com/firecracker-microvm/firecracker/blob/main/CONTRIBUTING.md#contribution-quality-standards).

______________________________________________________________________

- [x] This functionality cannot be added in [`rust-vmm`][1].

[1]: https://github.com/rust-vmm
[2]: https://github.com/firecracker-microvm/firecracker/blob/main/docs/api-change-runbook.md
[3]: https://github.com/firecracker-microvm/firecracker/blob/main/CONTRIBUTING.md

## Working environment

The repository is checked out at `/app/firecracker` at this PR's **base commit**
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
