#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `mobile/lib/pages/editing/edit.page.dart` (around line 85): A filename like `this.is.my.image.jpg` will become `this_edited.jpg` right? Maybe the `path` package can be used here
REVIEW_EOF
