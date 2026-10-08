#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `pkg/plugins/manager/loader/initializer/initializer.go` (around line 77): Ah I meant `GF_PLUGIN_VERSION` instead of `GF_VERSION` for here - I think the old one can stay where it is (even though I don't think many are depending on this for anything
REVIEW_EOF
