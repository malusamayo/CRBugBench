#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `capsules/src/net/thread/tlv.rs` (around line 1354): ```suggestion
                        u_bit: (timestamp_ticks & 1u16) > 0,
```
REVIEW_EOF
