#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `handler/src/main/java/io/netty/handler/ssl/ReferenceCountedOpenSslEngine.java` (around line 1523): Does this just mask the problem? My concern is that the contents of `String[] enabled` are what are truly enabled by the SSL engine and this is just filtering them out.
REVIEW_EOF
