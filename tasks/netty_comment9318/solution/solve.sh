#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `codec-http2/src/main/java/io/netty/handler/codec/http2/Http2ServerUpgradeCodec.java` (around line 172): It isn't clear to me why this is delayed. I'd more expect us to add all the handlers and then call `onHttpServerUpgrade`. Seems this is 15611dadb all over again.
REVIEW_EOF
