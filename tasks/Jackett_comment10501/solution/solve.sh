#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/Jackett.Common/Indexers/BJShare.cs` (around line 145): This line can throw an exception, change it for:
```
return match.Success ? match.Groups[1].Value.Split('/')[0] : title;
```
REVIEW_EOF
