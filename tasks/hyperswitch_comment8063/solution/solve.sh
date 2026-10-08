#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `api-reference-v2/openapi_spec.json` (around line 8933): It's an SDK flow breaking change. [SDK](https://github.com/juspay/hyperswitch-web/blob/main/src/Utilities/PaymentBody.res#L153) is sending `encypted_payload`. 
CC: @ArushKapoorJuspay
REVIEW_EOF
