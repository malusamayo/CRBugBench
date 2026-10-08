#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/router/src/core/payments/tokenization.rs`:

This pull request introduces the defect later reported as "[FIX] unmask last4 when metadata changed during /payments". The
problem a user observed, and its root cause:

When a metadata is changed during /payments and list customer payment method is called, last4 digits is getting masked. Unmask it and respond with raw string.

This same root cause must be fixed before merging.
REVIEW_EOF
