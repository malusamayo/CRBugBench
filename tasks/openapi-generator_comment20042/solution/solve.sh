#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `samples/client/petstore/java/okhttp-gson-dynamicOperations/src/main/java/org/openapitools/client/api/PetApi.java` (around line 277): I think this change was not intended and should be prevented, right? I.e. when `dynamicOperations` is set to `true`, these headers should not be added.
REVIEW_EOF
