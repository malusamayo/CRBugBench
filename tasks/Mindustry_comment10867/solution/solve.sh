#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `android/src/mindustry/android/AndroidLauncher.java` (around line 117): I might be missing something, but it could be possible that someone is loading a newer version of the mod with the same filename. Maybe it's worth checking to make sure that the size of the files is identical, and only skipping the copy in that case?
REVIEW_EOF
