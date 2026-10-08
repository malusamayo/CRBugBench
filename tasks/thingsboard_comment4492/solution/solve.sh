#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `common/transport/snmp/src/main/java/org/thingsboard/server/transport/snmp/service/SnmpTransportService.java` (around line 196): What if it is not present? Then we should reply with the error and not simply ignore the request!
REVIEW_EOF
