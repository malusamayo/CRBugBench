# Code Review Task

You are a maintainer reviewing a pull request to the `firecracker-microvm/firecracker` repository.

**PR title:** feat(vmm): Request permission for Intel AMX

**PR description / commit message:**

feat(vmm): Request permission for Intel AMX

Intel AMX (Advanced Matrix Extensions) was introduced in Intel Sapphire
Rapids to accelerate deep learning and AI workloads. Since it requires
a larger area to save its state, the TILEDATA feature is disabled by
default. We request permission for it by default because it can be
disabled via CPU template. Otherwise, kernels prior to v6.4 have a bug
where KVM_GET_SUPPORTED_CPUID returns an inconsistent state of TILECFG
enabled but TILEDATA disabled by default, causing guest's #GP fault on
xsetbv instruction.

Signed-off-by: Takahiro Itazuri <itazur@amazon.com>

## Working environment

The repository is checked out at `/app/firecracker` at this PR's **base commit**
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
