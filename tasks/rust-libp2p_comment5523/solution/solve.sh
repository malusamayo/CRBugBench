#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `transports/websocket-websys/src/lib.rs` (around line 157): I might be misreading, but wouldnt using `domain_found` to check for domains break previous impl, in other words, be a breaking change? Though im sure it might be rare (and would just be an additional san entry iirc), but there could be instances where one would have a certificate for a specific ip, no? If thats the route we are to go, it might be best to do a minor bump instead of a patch bump to the version.
REVIEW_EOF
