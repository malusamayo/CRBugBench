#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `Duplicati/Library/Backend/AzureBlob/AzureBlobWrapper.cs` (around line 150): If this is not awaited here, the exception handler will not catch the error, because the continuation will not be invoked until the task is awaited.
REVIEW_EOF
