# Code Review Task

You are a maintainer reviewing a pull request to the `bazelbuild/bazel` repository.

**PR title:** [9.2.0] Add `refines_constraint_value` attribute to `constraint_setting` (https://github.com/bazelbuild/bazel/pull/29655)

**PR description:**

Implements [Hierarchical constraint settings](https://docs.google.com/document/d/1Lq-0aPBOT0cat1wcFbnPmurbyo05NpZXu0uGq12H_HE) ([discussion #28877](https://github.com/bazelbuild/bazel/discussions/28877)).

Adds a new optional, label-valued `refines_constraint_value` attribute on `constraint_setting`. This lets a `constraint_setting` express that any of its `constraint_value`s refine (i.e., imply) a particular `constraint_value` of another setting (e.g. a `//libc/glibc:version` setting refining `//libc:glibc`).

This has two consequences:

* **Platform validation.** Any `platform` that declares a non-default `constraint_value` for a refining setting must also declare the refined `constraint_value` (directly or via a parent platform). Bazel reports an actionable error including a `buildozer` fixup.

* **`select()` specificity.** A condition that matches via a refining `constraint_value` is treated as more specific than a condition that matches only via the refined `constraint_value`, so both can co-exist in the same `select()` without producing an "ambiguous match" error.

> Note: the design doc calls this attribute `refines_value`. It is renamed to `refines_constraint_value` here for symmetry with `default_constraint_value`.

RELNOTES: The new `refines_constraint_value` attribute on `constraint_setting` can be used to indicate that any non-default value for that setting specified on a `platform` requires the refined value to also be specified.

Closes #29655.

PiperOrigin-RevId: 926078211
Change-Id: Ic82738f2771adf7469f267aeea9dc020f203f8e5

Commit https://github.com/bazelbuild/bazel/commit/a59ad366453bb731b255916277d34d5d536ca696

## Working environment

The repository is checked out at `/app/bazel` at this PR's **base commit**
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
