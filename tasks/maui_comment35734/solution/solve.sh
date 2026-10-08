#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `.github/workflows/ci-scan-lock-issues.yml` (around line 71): ⚠️ **Error Handling** — `|| echo` chain disables `set -e` inside `lock_issue`; `gh issue lock` failures are silently swallowed.

_Flagged by: 2/3 reviewers; bash semantics verified empirically_

The R5 commit added `lock_issue "$num" || echo "::warning::..."` at `:76` and `:85` to make the function tolerant of per-issue errors. But bash disables `set -e` inside any command participating in an `&&`/`||` chain. So if `gh issue lock` at this line fails (rate limit, transient 5xx), the next line `echo "Locked ..."` returns 0 → `lock_issue` returns 0 → the `|| echo warning` never fires. The actual lock failure is silently swallowed, and the workflow shows green while doing nothing.

**Empirically verified:**
```bash
$ bash -c 'set -e
  bar() { return 1; }
  baz() { bar; echo reached; }
  baz || echo warning'
reached
# exits 0, no "warning" printed
```

This silently undermines the very R3 finding the change was meant to address — "per-issue resilience" — by hiding exactly the failures it should surface. Reviewer 1 argued "fails safe," which is true for `gh api` fetch failures (downstream guards reject the data), but the `gh issue lock` path is the one that matters and it's not covered.

**Fix (one of):**

1. Explicit error handling inside the function — change `:71` to:
   ```bash
   if ! gh issue lock "${issue_number}" --repo "${GITHUB_REPOSITORY}"; then
     echo "::warning::Failed to lock #${issue_number}."
     return 1
   fi
   ```
   Then keep the `|| echo warning` at the call site for the case where the function genuinely returns 1.

2. Run the function in a subshell at the call site:
   ```bash
   ( lock_issue "${issue_number}" ) || echo "::warning::Failed to process #${issue_number}; continuing."
   ```
   The subshell preserves `set -e` behavior, so any failing command inside aborts the subshell and the subshell exits non-zero.
REVIEW_EOF
