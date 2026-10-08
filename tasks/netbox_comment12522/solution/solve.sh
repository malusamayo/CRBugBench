#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `netbox/templates/dcim/device.html` (around line 317): I believe the total weight will always be displayed in kilograms.
```suggestion
                                    {{ object.total_weight|floatformat }} Kilograms
```
REVIEW_EOF
