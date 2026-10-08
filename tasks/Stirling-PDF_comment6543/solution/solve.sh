#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `app/proprietary/src/main/java/stirling/software/proprietary/policy/input/FolderInputSource.java` (around line 181): I worry about how we do this...
Whats stopping the non-admin user making an automation which just reads config folder and grabs all settings and secrets...
We need to ensure folder scanning doesnt run on SaaS mode, and on non desktop it should probably be Admin only 
+ have  blacklists like our db/settings files
REVIEW_EOF
