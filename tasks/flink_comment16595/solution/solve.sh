#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `tools/ci/maven-utils.sh` (around line 107): all the options except the `--settings` one should be added to `MVN_GLOBAL_OPTIONS_WITHOUT_MIRROR`, shouldn't they?
REVIEW_EOF
