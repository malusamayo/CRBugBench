#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `controller-api/src/main/java/com/yahoo/vespa/hosted/controller/api/integration/resource/ResourceSnapshot.java` (around line 52): This constraint is correct, but the node list needs to be grouped by version beforehand. Otherwise the maintainer will fail whenever an application is upgrading, and nodes in the same cluster are on different Vespa versions.
REVIEW_EOF
