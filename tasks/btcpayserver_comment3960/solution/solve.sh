#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `BTCPayServer/Data/Payouts/LightningLike/UILightningLikePayoutController.cs` (around line 225): Don't use this one, you don't want a MailboxAddress (Nicolas Dorier < blah@blah.com >) you want an email address only. (blah@blah.com)
REVIEW_EOF
