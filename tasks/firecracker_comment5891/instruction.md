# Code Review Task

You are a maintainer reviewing a pull request to the `firecracker-microvm/firecracker` repository.

**PR title:** Add support for virtio device reset

**PR description:**

Add support for virtio device reset

## License Acceptance

By submitting this pull request, I confirm that my contribution is made under
the terms of the Apache 2.0 license. For more information on following Developer
Certificate of Origin and signing off your commits, please check
[`CONTRIBUTING.md`][3].

## PR Checklist

- [ ] I have read and understand [CONTRIBUTING.md][3].
- [ ] I have run `tools/devtool checkbuild --all` to verify that the PR passes
  build checks on all supported architectures.
- [ ] I have run `tools/devtool checkstyle` to verify that the PR passes the
  automated style checks.
- [ ] I have described what is done in these changes, why they are needed, and
  how they are solving the problem in a clear and encompassing way.
- [ ] I have updated any relevant documentation (both in code and in the docs)
  in the PR.
- [ ] I have mentioned all user-facing changes in `CHANGELOG.md`.
- [ ] If a specific issue led to this PR, this PR closes the issue.
- [ ] When making API changes, I have followed the
  [Runbook for Firecracker API changes][2].
- [ ] I have tested all new and changed functionalities in unit tests and/or
  integration tests.
- [ ] I have linked an issue to every new `TODO`.

______________________________________________________________________

- [ ] This functionality cannot be added in [`rust-vmm`][1].

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
