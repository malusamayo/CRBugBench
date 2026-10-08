#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `core/src/main/java/hudson/model/Queue.java` (around line 1637): Doing this changes some behaviour. 

Example:
```
p.transientCausesOfBlockage
```

will no longer get assigned on all buildable items.
REVIEW_EOF
