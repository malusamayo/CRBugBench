#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `BTCPayServer/Views/AppsPublic/ViewPointOfSale.cshtml` (around line 51): will not work, `Raw` can only be used in the context of an HTML doc, but you are inside the style tag. Look what I did when I fixed the vulnerability.
REVIEW_EOF
