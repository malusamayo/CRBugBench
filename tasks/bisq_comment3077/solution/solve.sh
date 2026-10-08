#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `desktop/src/main/java/bisq/desktop/main/account/content/altcoinaccounts/AltCoinAccountsView.java` (around line 176): By removing that it would require a min. height as otherwise the list can get truncated.
<img width="1202" alt="Screen Shot 2019-08-14 at 18 24 35" src="https://user-images.githubusercontent.com/1449498/63038237-fe3e3a00-bec0-11e9-8d6c-72ec727aef4c.png">
REVIEW_EOF
