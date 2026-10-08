#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `components/script/dom/performanceresourcetiming.rs` (around line 200): You will need to update PerformanceResourceTiming::from_resource_timing as well to initialize this member.
REVIEW_EOF
