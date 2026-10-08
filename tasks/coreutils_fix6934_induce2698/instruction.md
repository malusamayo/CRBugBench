# Code Review Task

You are a maintainer reviewing a pull request to the `uutils/coreutils` repository.

**PR title:** seq: use BigDecimal to represent floats (#2698)

**PR description / commit message:**

seq: use BigDecimal to represent floats (#2698)

* seq: use BigDecimal to represent floats

Use `BigDecimal` to represent arbitrary precision floats in order to
prevent numerical precision issues when iterating over a sequence of
numbers. This commit makes several changes at once to accomplish this
goal.

First, it creates a new struct, `PreciseNumber`, that is responsible for
storing not only the number itself but also the number of digits (both
integer and decimal) needed to display it. This information is collected
at the time of parsing the number, which lives in the new
`numberparse.rs` module.

Second, it uses the `BigDecimal` struct to store arbitrary precision
floating point numbers instead of the previous `f64` primitive
type. This protects against issues of numerical precision when
repeatedly accumulating a very small increment.

Third, since neither the `BigDecimal` nor `BigInt` types have a
representation of infinity, minus infinity, minus zero, or NaN, we add
the `ExtendedBigDecimal` and `ExtendedBigInt` enumerations which extend
the basic types with these concepts.

* fixup! seq: use BigDecimal to represent floats

* fixup! seq: use BigDecimal to represent floats

* fixup! seq: use BigDecimal to represent floats

* fixup! seq: use BigDecimal to represent floats

* fixup! seq: use BigDecimal to represent floats

## Working environment

The repository is checked out at `/app/coreutils` at this PR's **base commit**
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
