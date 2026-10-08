#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/EFCore/Storage/ValueConversion/IPAddressToBytesConverter.cs` (around line 24): Am not too sure about mapping IPAddress.None to null... None is a actually a valid value, equal to Broadcast (0x00000000FFFFFFFF).
REVIEW_EOF
