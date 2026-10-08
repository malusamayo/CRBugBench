#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/Aspire.Cli/Bundles/BundleService.cs` (around line 376): Is the limited exception handling intentional or would it make sense to do a simple catch all here? Otherwise there are failures that could bubble up instead of falling back to the null handler.
REVIEW_EOF
