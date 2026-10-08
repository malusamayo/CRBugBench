#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `alacritty/src/config/monitor.rs` (around line 17): The `PathBuf` inside the Path must be canocilized otherwise reload won't work properly in some cases if you're using relative path for in `--config-file`, since you'll be matching relative path against canonicalized once in a handler below.
REVIEW_EOF
