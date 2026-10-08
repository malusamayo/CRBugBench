#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `core/src/components/input/input.ionic.scss` (around line 64): ```suggestion
  --background: #{tokens.$ionic-color-neutral-10};
  
  pointer-events: none;
```

This needs to be added to prevent the hover state on disabled inputs
REVIEW_EOF
