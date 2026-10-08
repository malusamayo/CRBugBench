#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `xchange-bitstamp/src/main/java/org/knowm/xchange/bitstamp/service/BitstampAccountServiceRaw.java` (around line 96): Why was this rounding to 5 decimal places added? Is there some significant figure requirement with the new API? I am not seeing this in the new Bitstamp API documentation at first glance.
REVIEW_EOF
