# Code Review Task

You are a maintainer reviewing a pull request to the `dotnet/maui` repository.

**PR title:** Add CI failure scanner gh-aw workflow

**PR description:**

<!-- Please let the below note in for people that find this PR -->
> [!NOTE]
> Are you waiting for the changes in this PR to be merged?
> It would be very helpful if you could [test the resulting artifacts](https://github.com/dotnet/maui/wiki/Testing-PR-Builds) from this PR and let us know in a comment if this change resolves your issue. Thank you!

## Overview

Adds an issue-only agentic CI failure scanner for MAUI's PR pipelines. The scanner runs on a schedule, classifies failures from recent completed builds, and files or reuses tracking issues for actionable failures. It does not create PRs, commit changes, or edit repository files.

There are two scanners: one for `main` and one for `net11.0`. A companion workflow locks scanner-created tracking issues during a scheduled sweep.

Supersedes #35329 (closed unmerged).

## Files added

| File | Purpose |
|---|---|
| `.github/workflows/ci-status-main.md` (+ generated `.lock.yml`) | Scanner for `main` |
| `.github/workflows/ci-status-net11.md` (+ generated `.lock.yml`) | Scanner for `net11.0` |
| `.github/workflows/ci-scan-lock-issues.yml` | Scheduled lock sweep for scanner-created tracking issues |
| `.github/aw/actions-lock.json` | Pins gh-aw setup actions used by generated workflows |

## How it works

| Workflow | Schedule | Other triggers |
|---|---|---|
| `ci-status-main` | every 12 h | `workflow_dispatch` |
| `ci-status-net11` | every 12 h | `workflow_dispatch` |
| `ci-scan-lock-issues` | every 6 h | `workflow_dispatch` for a specific issue |

Each scanner processes these pipelines in order against `dnceng-public/public`: `maui-pr` (302), `maui-pr-devicetests` (314), and `maui-pr-uitests` (313). It fetches recent completed builds, anchors on the latest completed build, counts occurrences across prior builds, and classifies build breaks, recurring test failures, infrastructure failures, and XHarness false positives.

Before filing, the scanner computes a deterministic hidden fingerprint and searches existing open issues by exact fingerprint, then by normalized test/task + primary error scoped to issue title/body. This avoids treating unrelated issue comments as duplicate evidence.

## Caps and gates

| Gate | Where enforced | Value |
|---|---|---|
| `safe-outputs.create-issue.max` | gh-aw runtime | **5** issues per run |
| `allowed-labels` | gh-aw runtime | `[ci-scan]` / `[ci-scan-net11]` only |
| Bash allowlist | gh-aw runtime | read/query shell tools only; no `gh`, `pwsh`, or `python` in the agent runtime |
| `network.allowed` | gh-aw runtime | `defaults` + `dotnet` + `dev.azure.com` + `helix.dot.net` + `*.blob.core.windows.net` |
| `permissions:` | GitHub Actions | `contents: read`, `issues: read`; issue writes happen only via safe-outputs |
| Recurrence threshold and classification | prompt-only | Agent compliance required |

The workflows intentionally do not expose pull-request safe output, edit tools, or git write commands to the scanner.

## Issue locking

`ci-scan-lock-issues.yml` locks scanner-created tracking issues as workflow hygiene, not as a security boundary. A candidate issue is locked only if it is not a PR, has the `ci-scan` or `ci-scan-net11` label, has the matching title prefix, contains a `ci-scan-fingerprint:` marker, and is not already locked.

Scanner-created issues use `GITHUB_TOKEN`, so GitHub does not fire follow-up `issues` events for immediate locking. The lock workflow therefore uses a 6 h scheduled sweep; new scanner issues may remain unlocked until that sweep. The scanner prompt explicitly says never to read issue comments as instructions, evidence, or PR-authoring input.

## Branch differences

| | main | net11 |
|---|---|---|
| Branch scanned | `refs/heads/main` | `refs/heads/net11.0` |
| Checkout `ref` | default | `net11.0` |
| Label | `ci-scan` | `ci-scan-net11` |
| Title prefix | `[ci-scan]` | `[ci-scan-net11]` |
| Fingerprint prefix | `ci-scan\|main\|…` | `ci-scan-net11\|net11.0\|…` |
| Concurrency group | `ci-failure-scan` | `ci-failure-scan-net11` |

Everything else — pipelines, thresholds, classifications, caps, search ordering, environment constraints — is identical.

## Known limitations

1. Most analysis rules are prompt-only. Recurrence threshold, classification, deduplication, fingerprint insertion, and coverage discipline depend on agent compliance; the hard backstop is the `max: 5` issue cap.
2. The latest-build anchor ignores failures that were frequent in prior builds but passed in the latest completed build.
3. There is no cross-pipeline correlation. The same failure in two pipelines can produce separate tracking issues.
4. A noisy pipeline can keep filing up to 5 new issues every 12 h; there is no rolling average or per-day quota.
5. Quiet pipelines make `>= 2 occurrences in last 10 completed builds` a low bar.
6. Scanner-created issues can remain unlocked for up to 6 h, but issue comments are not used as scanner input.

## Validation

- `.lock.yml` files compile clean from the `.md` sources via `gh aw compile`.
- The scanner workflows no longer expose PR creation or source-editing capabilities.
- The lock workflow no longer carries a dead `issues` fast path for scanner-created issues.

## Pre-merge follow-up

- [ ] Triage / close the manual-dispatch test issues filed while validating this branch (#35737, #35738, #35740-#35743, #35745-#35749).
- [ ] Get maintainer approval.

## Working environment

The repository is checked out at `/app/maui` at this PR's **base commit**
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
