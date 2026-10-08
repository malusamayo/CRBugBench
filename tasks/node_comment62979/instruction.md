# Code Review Task

You are a maintainer reviewing a pull request to the `nodejs/node` repository.

**PR title:** lib: refactor internal webidl converters

**PR description:**

Rework lib/internal/webidl.js into a documented shared converter module that follows the Web IDL conversion algorithms more closely.

Improvements:
- Add documented converters and helper factories for primitive values, dictionaries, enums, sequences, interfaces, required arguments, integers, `Uint8Array`, and `BufferSource`.
- Move WebCrypto onto the shared converters, while keeping compatibility wrappers for its existing `BufferSource` and `BigInteger` behavior.
- Use shared converters from Blob, Performance, Web Locks, and structured clone option handling.
- Add benchmarks for `ConvertToInt` and WebCrypto Web IDL converter hot paths.
- Add focused tests for core converters, WebCrypto converters, integer conversion, and buffer source behavior.

Fixes:
- Make the shared `BufferSource` and `Uint8Array` converters reject resizable `ArrayBuffer` and growable `SharedArrayBuffer` backing stores unless explicitly allowed. WebCrypto preserves its legacy resizable backing-store behavior through compatibility wrappers until a semver-major follow-up can opt in to the stricter behavior.
- Use Web IDL `ToNumber` and `ToString` behavior for BigInt, Symbol, and object primitive conversion.
- Use exact BigInt modulo for 64-bit `ConvertToInt` wrapping and document the final Number approximation behavior.
- Normalize mathematical modulo results to `+0` where Web IDL requires it.
- Process inherited dictionaries in least-derived to most-derived order, sorting members only within each dictionary level.
- Use `IteratorComplete` truthiness for sequence conversion.
- Cover detached buffers, resizable-backed views, growable-backed views, cross-realm buffer sources, mutation-after-call behavior, inherited dictionary member order, and sequence iterator completion behavior.

Benchmark(s)

- ~https://github.com/nodejs/node/pull/62979#issuecomment-4325899938~
- https://github.com/nodejs/node/pull/62979#issuecomment-4327520436

## Working environment

The repository is checked out at `/app/node` at this PR's **base commit**
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
