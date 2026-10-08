#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `ci/code_checks.sh` (around line 130): Does the `--include` work with quotes as written? It's not detecting instances of the pattern for me when the quotes are present, but without the quotes, `--include=*.{py,pyx}`, it is detecting the pattern.  I'm stuck on the windows subsytem for linux at the moment though, so it could just be some weirdness with that.
REVIEW_EOF
