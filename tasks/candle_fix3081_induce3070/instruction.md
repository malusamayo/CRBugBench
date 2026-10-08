# Code Review Task

You are a maintainer reviewing a pull request to the `huggingface/candle` repository.

**PR title:** [Metal] Refactor (#3070)

**PR description / commit message:**

[Metal] Refactor (#3070)

* Initial metal-rs -> objc2-metal conversion

* Using objc2_metal bindings in metal kernels

* Use objc2_metal for mlx kernels

* Use objc2_metal for tests

* Use objc2_metal for metal benchmarks

* tidy

* Remove AllocationError. Use existing FailedToCreateResource

* All candle-metal-kernels tests passing

* Fix set_threadgroup_memory_length, fmt

* Update cargo tomls with objc2 libs

* Update candle-core metal usage

* impl Send/Sync for metal Device and Library structs

* tidy up imports

* Move .metal files to src/kernels/

* Begin refactor of candle-metal-kernels

* Refactor candle-core metal usage

* Delete old tmp folder

* Extract library to its own file

* Tidy up imports

* Refactor metal buffer concepts

* Refactor metal commandbuffer

* Refactor metal blit and compute command encoders

* Refactor metal compute pipeline

* Refactor metal commands struct

* Refactor metal Kernels

* Refactor kernel Source

* Extract MetalKernelError to err file

* Rename kernels/ -> metal_src/

* Add kernels folder for specific kernel call impls

* Move unary impls into kernels/unary.rs

* Move binary impls into kernels/binary.rs

* Move ConstantValues impl to metal::library

* Move sdpa impls into kernels::sdpa

* Move quantized impls into kernels::quantized

* Move cast impls into kernels::cast

* Move reduce impls into kernels::reduce

Technically not all of these are reduce ops.
That will have to wait for another day.

* Move copy into kernels::cast. Simplify imports

* Move affine impls into kernels::affine

* Move ternary impls into kernels::ternary

* Move indexing impls into kernels::indexing

* Simplify imports

* Move random impls into kernels::random

* Move conv impls into kernels::convolution

Again several impls are not specifically convolution.
Another day.

* Move fill impl into kernels::fill

## Working environment

The repository is checked out at `/app/candle` at this PR's **base commit**
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
