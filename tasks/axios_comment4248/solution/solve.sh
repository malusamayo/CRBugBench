#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `lib/core/InterceptorManager.js` (around line 43): Since the default value is `[]` and all methods are handled with `this.handlers` as an array I think you could set it as `[]` 🤔 

```js
this.handlers = [];
```
REVIEW_EOF
