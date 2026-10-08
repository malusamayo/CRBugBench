#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `app/src/main/res/menu/menu_feed_fragment.xml` (around line 7): I think these should start from 2, since the search item visible when the feed fragment is added as a tab to the main fragment takes order 1.
REVIEW_EOF
