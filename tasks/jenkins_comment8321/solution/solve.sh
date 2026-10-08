#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `core/src/main/resources/jenkins/console/ConsoleUrlProviderGlobalConfiguration/config.jelly` (around line 3): why is this permission check needed it's a global configuration value?

This prevents System read users from even seeing the config which seems wrong
REVIEW_EOF
