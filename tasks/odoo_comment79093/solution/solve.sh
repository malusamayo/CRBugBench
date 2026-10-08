#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `addons/sale/models/sale_order_line.py` (around line 653): ```suggestion
                line.product_custom_attribute_value_ids = False
```
The attributes can be removed when there is no product set.
REVIEW_EOF
