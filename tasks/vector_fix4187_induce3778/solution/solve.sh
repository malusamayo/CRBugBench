#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `graphql/subscriptions/uptime_metrics.graphql`:

This pull request introduces the defect later reported as "Fix flaky `uptime_metrics` tests for macOS". The
problem a user observed, and its root cause:

https://github.com/timberio/vector/pull/3778#issuecomment-698622017 is still occasionally an issue in macOS CI tests. The interval fix I suggested in that thread seems to have fixed it locally, so I think this probably hints at it being a race condition of some kind.

This same root cause must be fixed before merging.
REVIEW_EOF
