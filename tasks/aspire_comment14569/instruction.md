# Code Review Task

You are a maintainer reviewing a pull request to the `microsoft/aspire` repository.

**PR title:** Replace Playwright MCP server with Playwright CLI installation

**PR description:**

## Summary

Replaces the Playwright MCP server configuration in `aspire agent init` with a secure Playwright CLI installation workflow.

### What changed

Instead of writing MCP server configuration JSON to each agent environment's config file (different formats for VS Code, Claude Code, Copilot CLI, and OpenCode), the new approach:

1. Resolves the `@playwright/cli` package version from npm registry
2. Downloads the package tarball via `npm pack`
3. Verifies supply chain integrity (SHA-512 SRI hash comparison)
4. Runs `npm audit signatures` for provenance verification
5. Installs globally from the verified tarball
6. Runs `playwright-cli install --skills` to generate skill files

### New abstractions

- **`INpmRunner`/`NpmRunner`**: npm CLI command runner (resolve, pack, audit, install)
- **`IPlaywrightCliRunner`/`PlaywrightCliRunner`**: playwright-cli command runner
- **`PlaywrightCliInstaller`**: orchestrates the full secure install flow with SRI hash verification

### Impact

- Removes ~400 lines of per-scanner MCP config writing code
- Replaces 4 different JSON config formats with a single global CLI install
- Adds supply chain security (integrity verification + signature audit)
- Skill files are managed by the Playwright CLI itself

### Related

- Fixes #14430
- Related: microsoft/playwright#39317 (`.agents/skills/` directory support in Playwright CLI)
- Related: https://github.com/nicolo-ribaudo/tc39-proposal-structs/issues/11 (linked from the Playwright PR)

### Testing

- All 1282 existing CLI tests pass
- Added 11 new unit tests for `PlaywrightCliInstaller` covering:
  - npm resolve failure
  - Already installed (same/newer version) skip logic
  - Pack failure
  - Integrity check pass/fail
  - Global install failure
  - Upgrade from older version
  - SRI hash verification (matching, non-matching, wrong algorithm)

## Working environment

The repository is checked out at `/app/aspire` at this PR's **base commit**
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
