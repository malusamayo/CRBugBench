#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/vmm/src/devices/virtio/device.rs` (around line 192): should this be called before the rest? This is a semantic change from the old code where a failed reset left the device activated.
REVIEW_EOF
