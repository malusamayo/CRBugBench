# Code Review Task

You are a maintainer reviewing a pull request to the `huggingface/transformers` repository.

**PR title:** feat(ci): add continuous batching to benchmarks (#41916)

**PR description / commit message:**

feat(ci): add continuous batching to benchmarks (#41916)

* feat(ci): add continuous batching to benchmarks

* refactor(ci): PR comments

* refactor(cb): when stopping, block by default

* fix(benchmarks): `stream` -> `streaming`

* fix(benchmarks): invalid configuration when cb has attn_impl == sdpa

* tests(cb): fix attn impl

* fix(benchmarks): update `get_throughput` formula

* fix(benchmarks): prevent version conflicts and ensure proper cleanup in continuous batching (#42063)

* Initial plan

* fix(benchmarks): ensure proper cleanup and remove transformers from requirements

- Remove transformers from benchmark_v2/requirements.txt to prevent version conflicts
- Add try-finally block to ensure ContinuousBatchingManager.stop() is always called
- This fixes TypeError about unexpected 'streaming' argument and prevents OOM from improper cleanup

Co-authored-by: McPatate <9112841+McPatate@users.noreply.github.com>

---------

Co-authored-by: copilot-swe-agent[bot] <198982749+Copilot@users.noreply.github.com>
Co-authored-by: McPatate <9112841+McPatate@users.noreply.github.com>

* fix(benchmarks): raise the exception on failure instead of ignoring

we catch the exception later on and raising it here helps debugging
because it will be logged

* test(cb): comment out failing tests for now

added a `FIXME` mark

* fix(benchmarks): revert `finally` removal but keep raising exception

* test(cb): fix missing `require_read_token` import

* refactor(benchmarks): error if no benchmarks were run

* refactor(benchmarks): change default lvls of cb bench config

---------

Co-authored-by: Copilot <198982749+Copilot@users.noreply.github.com>
Co-authored-by: McPatate <9112841+McPatate@users.noreply.github.com>

## Working environment

The repository is checked out at `/app/transformers` at this PR's **base commit**
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
