#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `java/src/org/openqa/selenium/devtools/v127/v127Network.java` (around line 130): This would complain about http 200.

Should be `if (code >= 300 && code <= 399) {` in my mind.
REVIEW_EOF
