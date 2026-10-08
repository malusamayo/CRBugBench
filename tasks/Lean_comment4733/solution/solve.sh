#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `Algorithm.Framework/Selection/OpenInterestFutureUniverseSelectionModel.cs` (around line 98): `exchangeHours.TimeZone` isn't the data timezone but the exchange time zone. Instead of sending in the `SecurityExchangeHours` above, we could send the entire entry which has the data time zone
REVIEW_EOF
