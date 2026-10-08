#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `components/script/dom/stereopannernode.rs` (around line 47): You need to validate based on constraints here, see https://webaudio.github.io/web-audio-api/#audionode-channelcount-constraints , https://webaudio.github.io/web-audio-api/#dom-audionode-channelcountmode : if the channel count mode is Max or the channel count is greater than two, return a NotSupported Error

You'll also need to add similar constraints on SetChannelCount and SetChannelCountMode on audionode.rs
REVIEW_EOF
