# Code Review Task

You are a maintainer reviewing a pull request to the `OpenBB-finance/OpenBB` repository.

**PR title:** feat(platform): extend Country type standardization to equity screeners

**PR description:**

# Pull Request for OpenBB Platform

## Description

- [x] **Summary:** Extend the standardized `Country` type from PR #7333 to equity screeners and calendar endpoints.
- [x] **Link:** Continues work from #7333, addresses #6969
- [x] **Motivation:** Provide consistent country input handling across equity and calendar endpoints.

### Changes

**YFinance equity_screener:**
- Accept ISO alpha-2/alpha-3 codes, country names, or snake_case
- Validates against YFinance's supported country list
- Converts to lowercase alpha-2 format expected by YFinance

**Nasdaq equity_screener:**
- Accept ISO codes, country names in addition to existing snake_case
- Preserves multi-value (comma-separated) functionality
- Converts all inputs to Nasdaq's snake_case format

**Nasdaq economic_calendar:**
- Accept ISO codes, country names in addition to existing snake_case
- Preserves multi-value (comma-separated) functionality

**Seeking Alpha calendar_earnings:**
- Accept ISO codes, country names (normalizes to 'us' or 'ca')
- Validates against supported countries (US, Canada only)

### Example Usage

```python
# YFinance example:
obb.equity.screener(country='US', provider='yfinance')
obb.equity.screener(country='USA', provider='yfinance')
obb.equity.screener(country='United States', provider='yfinance')
obb.equity.screener(country='united_states', provider='yfinance')
```

There are many other endpoints across providers that use country parameters:

| Scope | Providers/Files | Complexity |
|-------|-----------------|------------|
| **This PR** | YFinance, Nasdaq screeners, Nasdaq calendar, SA earnings | Low |
| **Extended** | FMP etf_search | Low-Medium |
| **Full** | OECD (6 files), EconDB (4), IMF (6), FRED (2) | High (custom mappings) |

**Should this be extended further?** The full approach would require careful handling of provider-specific country mappings (e.g., OECD uses custom codes, IMF has its own country identifiers).

Happy to expand scope based on feedback.

---

- [x] I have read the [Contributing Guidelines](https://github.com/OpenBB-finance/OpenBB/blob/develop/CONTRIBUTING.md)
- [x] Update tests to reflect changes
- [x] All tests pass locally

## Working environment

The repository is checked out at `/app/OpenBB` at this PR's **base commit**
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
