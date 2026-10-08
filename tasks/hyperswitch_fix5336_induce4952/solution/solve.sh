#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/router/src/core/payments/routing.rs`:

This pull request introduces the defect later reported as "do not update `perform_session_flow_routing` output if the `SessionRoutingChoice` is none". The
problem a user observed, and its root cause:

While performing the session token routing we create an empty vec that will contain the Routing choices for that particular session. In case if there is no connectors that requires session call then the `perform_session_flow_routing` will return the empty vec. Instead if there is no connectors that requires session call, then we should just return empty hashmap.

This same root cause must be fixed before merging.
REVIEW_EOF
