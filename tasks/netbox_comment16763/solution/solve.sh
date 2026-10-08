#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `netbox/templates/core/plugin.html` (around line 43): It's not the plugin itself we need to check here, but rather the edition of NetBox. Only the Community edition should include instructions for local installation; Cloud & Enterprise will have different means of installing the plugin.
REVIEW_EOF
