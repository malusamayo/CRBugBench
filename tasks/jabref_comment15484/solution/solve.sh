#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `jabgui/src/main/java/org/jabref/gui/importer/actions/OpenDatabaseAction.java` (around line 195): But why the file is added in this loop? Shouldn't it just filter out the files?
REVIEW_EOF
