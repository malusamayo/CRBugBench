#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `codec/src/main/java/io/netty/handler/codec/base64/Base64.java` (around line 143): We should still call dst.release() if it's not the same as destBuf
REVIEW_EOF
