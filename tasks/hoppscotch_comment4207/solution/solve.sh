#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `packages/hoppscotch-backend/src/user-collection/user-collection.resolver.ts` (around line 406): ```suggestion
      description: 'Type of UserCollection',
      type: () => ReqType,
```

The type is inferred as `String!` without the above.
REVIEW_EOF
