# Code Review Task

You are a maintainer reviewing a pull request to the `tensorflow/tfjs` repository.

**PR title:** Add a complex64 dtype. (#1213)

**PR description / commit message:**

Add a complex64 dtype. (#1213)

Adds a complex64 dtype to the Tensor class.

Adds support for:
- tf.complex, tf.real, tf.imag
- tf.reshape, tf.clone, tf.cast
- tf.add, tf.sub, tf.mul

In the WebGL backend, we add a new field to TextureData which points a DataId to an optional array of complex components (real and imaginary). These are stored as completely separate Tensors, and any operations on complex numbers will delegate to operations on the underlying Tensors.

I added a complicated operation, tf.mul, which generates real and imaginary parts and has to blend the real and imaginary parts of the input. This will serve as a starting point for the FFT PR.

FEATURE

## Working environment

The repository is checked out at `/app/tfjs` at this PR's **base commit**
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
