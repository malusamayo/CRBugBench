#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `xchange-stream-kraken/src/main/java/info/bitrich/xchangestream/kraken/KrakenStreamingAdapters.java` (around line 94): the date should be null if we cannot figure out the data from the snapshot or bids/asks because otherwise you are just timestamping the time we received the message
REVIEW_EOF
