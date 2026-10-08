#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/router/src/core/relay.rs`:

This pull request introduces the defect later reported as "fix(relay): Remove raw connector response population logic for unreferenced refunds". The
problem a user observed, and its root cause:

The raw connector response contains connector authentication details, which could potentially expose sensitive credentials. Therefore, we removed storing the raw connector response in the relay response_data column.

This same root cause must be fixed before merging.
REVIEW_EOF
