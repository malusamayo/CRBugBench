#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `core/src/main/java/jenkins/telemetry/impl/PasswordMasking.java` (around line 101): Existing `Telemetry` implementations that collect information about frequency (`UserLanguages`, `StaplerDispatches`) clear their collection when this is invoked (usually daily). This one does not. Why?
REVIEW_EOF
