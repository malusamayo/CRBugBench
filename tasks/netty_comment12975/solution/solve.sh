#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `codec-http2/src/main/java/io/netty/handler/codec/http2/DefaultHttp2Headers.java` (around line 178): RevAPI says we need to keep the override to preserve binary compatibility for subclasses.
REVIEW_EOF
