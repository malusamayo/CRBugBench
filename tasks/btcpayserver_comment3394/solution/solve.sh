#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `BTCPayServer/Controllers/UIInvoiceController.UI.cs` (around line 873): You might also need to check if the available payment methods have been disabled (there are helper methods in the store blob)
REVIEW_EOF
