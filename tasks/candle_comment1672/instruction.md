# Code Review Task

You are a maintainer reviewing a pull request to the `huggingface/candle` repository.

**PR title:** Add support for loading Fortran contiguous tensors

**PR description:**

This commit introduces the ability to handle Fortran contiguous tensors in the tensor loading process. Previously, the code only supported loading tensors that were contiguous in memory, failing with an error for non-contiguous tensors. With this update, tensors identified as Fortran contiguous (column-major order) are now correctly handled by reversing their dimensions after loading. This enhancement ensures broader compatibility with different tensor layouts, improving the robustness of tensor loading operations.

- Check if a tensor is Fortran contiguous using the `is_fortran_contiguous` flag.
- For Fortran contiguous tensors, reverse the dimensions after loading to correctly represent their layout in memory.
- Continue to bail out with an error for tensors that are neither C contiguous nor Fortran contiguous, maintaining the previous behavior for non-contiguous tensors without explicit support.

This change addresses the issue of loading Fortran contiguous tensors, which was previously unsupported, thereby extending the functionality of the tensor loading mechanism to accommodate a wider variety of tensor layouts.

I have tested with Whisper's pt files and added a new unit test just to cover this special case.

## Working environment

The repository is checked out at `/app/candle` at this PR's **base commit**
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
