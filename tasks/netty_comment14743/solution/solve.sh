#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `common/src/main/java/io/netty/util/concurrent/GlobalEventExecutor.java` (around line 240): This needs to be an inner class. In 4.1 our Java support goes back to Java 1.6.
REVIEW_EOF
