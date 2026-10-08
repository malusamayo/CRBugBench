# Code Review Task

You are a maintainer reviewing a pull request to the `axios/axios` repository.

**PR title:** fix: custom auth headers not stripped on cross-origin redirects

**PR description:**

Found this while auditing redirect behavior in a service that uses `X-API-Key` for authentication. Standard headers like `Authorization` are stripped correctly on cross-origin redirects, but any custom auth headers survive the redirect to the new origin.

This extends the existing cross-origin header-stripping logic to also cover a configurable list of sensitive header names via the new `sensitiveHeaders` config option. On a cross-origin redirect, any header in that list is removed from the outgoing request.

Refs #10711.

<!-- This is an auto-generated description by cubic. -->
---
## Summary by cubic
Fixes a security bug where custom auth headers could leak on cross-origin redirects in the Node HTTP adapter. Adds a case-insensitive `sensitiveHeaders` option with fail-closed origin checks and prototype‑pollution guards.

## Description

- Summary of changes
  - Add `options.beforeRedirects.sensitiveHeaders` to strip caller‑listed headers on cross‑origin redirects (case‑insensitive).
  - Implement `isSameOriginRedirect` (fail closed on parse errors) and export `__isSameOriginRedirect` for tests.
  - Validate `sensitiveHeaders` as an array of strings; reject with `ERR_BAD_OPTION_VALUE` otherwise.
  - Ignore `Object.prototype.sensitiveHeaders` when reading config.
  - Add `sensitiveHeaders?: string[]` to `index.d.ts` and `index.d.cts`.
  - Update threat model to `follow-redirects@^1.16.0`.
  - Move usage notes to `PRE_RELEASE_CHANGELOG.md`; keep README snippet.

- Reasoning
  - Prevent leaking custom secrets (for example `X-API-Key`) to other origins while preserving same‑origin behavior.

- Additional context
  - Node HTTP adapter only; unused when `maxRedirects` is `0`.

## Docs

Add `/docs/` updates with `sensitiveHeaders` examples and security notes. Keep them aligned with the README snippet and the new entry in `PRE_RELEASE_CHANGELOG.md`.

## Testing

Added/updated unit tests for:
- Cross‑origin stripping, same‑origin preservation, and case‑insensitive matching.
- Instance‑level config and invalid config rejection.
- Fail‑closed origin parsing via `__isSameOriginRedirect`.
- Prototype‑pollution guard to ignore `Object.prototype.sensitiveHeaders`.

## Semantic version impact

Patch: backward‑compatible security hardening behind an optional Node‑only config.

<sup>Written for commit d493090a1ff1126352cccd1fb533e0e78da94d70. Summary will update on new commits.</sup>

<a href="https://cubic.dev/pr/axios/axios/pull/10892?utm_source=github" target="_blank" rel="noopener noreferrer" data-no-image-dialog="true"><picture><source media="(prefers-color-scheme: dark)" srcset="https://cubic.dev/buttons/review-in-cubic-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://cubic.dev/buttons/review-in-cubic-light.svg"><img alt="Review in cubic" src="https://cubic.dev/buttons/review-in-cubic-dark.svg"></picture></a>

<!-- End of auto-generated description by cubic. -->

## Working environment

The repository is checked out at `/app/axios` at this PR's **base commit**
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
