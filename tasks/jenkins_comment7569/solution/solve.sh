#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `war/src/main/js/api/search.js` (around line 8): 🐛 
```suggestion
  return fetch(`${address}?query=${encodeURIComponent(searchTerm)}`);
```

Tested locally with just `a&b`, only `a` is received.
The & will "escape" the query part and create another property=value in the URL. I don't think there is a security impact but more a bug.
REVIEW_EOF
