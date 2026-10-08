#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `flutter/build_android.sh` (around line 3): default should be release, because this sh is meant to be for release originally, please do not change orignal behavior when adding new behavior.
REVIEW_EOF
