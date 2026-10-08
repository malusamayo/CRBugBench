#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `main/webapp/modules/core/scripts/facets/text-search-facet.js` (around line 144): This line throws an error:

<img width="960" alt="2020-07-01" src="https://user-images.githubusercontent.com/52909743/86229511-72eb9700-bbad-11ea-94be-c76f01f17e1e.png">

If I switch it back to `this._elmts`, it works just fine and the `next` and `last` buttons work as well.
REVIEW_EOF
