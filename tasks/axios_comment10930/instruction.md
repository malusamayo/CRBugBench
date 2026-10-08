# Code Review Task

You are a maintainer reviewing a pull request to the `axios/axios` repository.

**PR title:** fix(http): accept path-only url when socketPath is set (#6611)

**PR description:**

## Summary

`axios({ url: '/foo', socketPath: '/tmp/x.sock' })` worked in 1.7.3 and started throwing `TypeError [ERR_INVALID_URL]` in 1.7.4 when `new URL(fullPath, ...)` was added to the node dispatch path. `new URL('/foo')` rejects path-only URLs because no base is supplied.

This restores the 1.7.3 behaviour by supplying a synthetic `http://localhost` base **only when `config.socketPath` is set**. Non-socket requests are untouched; absolute URLs continue to ignore the base per the URL spec, so this is a no-op for those cases.

Follows @jasonsaayman's guidance on the earlier attempt (#6623): "detect `config.socketPath` and synthesise a base (`http://localhost`) … with a test."

## Linked issue

Closes #6611

## Changes

- `lib/adapters/http.js`: pick `'http://localhost'` as the `new URL()` base when `config.socketPath` is set; keep `platform.origin` / `undefined` for all other cases.
- `tests/unit/adapters/http.test.js`: regression test in the existing `socketPath security` describe block — `axios.get('/echo?q=1', { socketPath })` reaches the Unix server with `req.url === '/echo?q=1'`. Verified the test fails on `v1.x` (same `Invalid URL` error from the issue's stack trace) and passes with this patch.
- `PRE_RELEASE_CHANGELOG.md`: bug-fix entry under Unreleased.

#### Checklist

- [x] Tests added or updated (or N/A with reason)
- [x] Docs / types updated if public API changed (`index.d.ts` and `index.d.cts`) — N/A, no public API change
- [x] No breaking changes (or called out explicitly above)

<sub>AI-assisted (Claude Opus 4.7). Commit subject is one line per author preference; happy to amend in an `Assisted-by:` trailer if reviewers prefer.</sub>

<!-- This is an auto-generated description by cubic. -->
---
## Summary by cubic
Restores support for path-only URLs like `/foo` when `socketPath` is set in Node, and ignores prototype-polluted `socketPath` values. Only socket requests get a synthetic `http://localhost` base; all other URLs are unchanged.

## Description

- Summary of changes
  - `lib/adapters/http.js`: read `socketPath` via `own('socketPath')`; if set, use `http://localhost` as the `new URL()` base; otherwise keep existing base logic.
  - Tests: add regression tests for path-only URL over a Unix socket and with `allowedSocketPaths`, plus a security test that ignores prototype-polluted `socketPath`.
  - Changelog: add Bug Fix entry.

- Reasoning
  - `new URL('/foo')` needs a base. Supplying one only for real socket requests restores 1.7.3 behavior and prevents prototype pollution.

- Additional context
  - Regression introduced in 1.7.4; absolute URLs and non-socket requests are unaffected.

## Docs

Add a note in `/docs/` (Node HTTP adapter / Unix sockets) that:
- Path-only URLs are supported when `socketPath` is set.
- Only an own `socketPath` is honored for security.

## Testing

- Added unit tests for:
  - Path-only URL with `socketPath`.
  - Path-only URL with `allowedSocketPaths`.
  - Ignoring prototype-polluted `socketPath` (asserts `ERR_INVALID_URL` and zero requests).
- No further tests needed.

## Semantic version impact

Patch.

<sup>Written for commit 02d8f0bf9bca63386bc3dd5ff0d59b235ab631ef. Summary will update on new commits.</sup>

<a href="https://cubic.dev/pr/axios/axios/pull/10930?utm_source=github" target="_blank" rel="noopener noreferrer" data-no-image-dialog="true"><picture><source media="(prefers-color-scheme: dark)" srcset="https://www.cubic.dev/buttons/review-in-cubic-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://www.cubic.dev/buttons/review-in-cubic-light.svg"><img alt="Review in cubic" src="https://www.cubic.dev/buttons/review-in-cubic-dark.svg"></picture></a>

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
