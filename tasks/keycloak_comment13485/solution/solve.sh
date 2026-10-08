#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `services/src/main/java/org/keycloak/forms/login/freemarker/FreeMarkerLoginFormsProvider.java` (around line 316): Try changing to `replacePath`. Otherwise, the resulting URL would include two occurrences of `/auth`.
REVIEW_EOF
