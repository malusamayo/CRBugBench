#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `BTCPayServer/Data/Payouts/BitcoinLike/BitcoinLikePayoutHandler.cs` (around line 350): the fact that `proof.Accounted` is false, does not mean it is external. It may have been like that already in the previous proof. I think you should check `isInternal` rather than using `else`.
REVIEW_EOF
