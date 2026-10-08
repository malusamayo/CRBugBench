#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/main/java/stirling/software/SPDF/controller/api/DatabaseController.java` (around line 35): This whole section should only be allowed by admins,
I suggest a 
@PreAuthorize("hasRole('ROLE_ADMIN')")
REVIEW_EOF
