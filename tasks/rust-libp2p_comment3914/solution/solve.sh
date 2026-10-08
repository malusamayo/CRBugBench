#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `protocols/request-response/src/handler.rs` (around line 90): Is this bounded somehow? Previously we would leverage the `libp2p-swarm` [max_negotiating_inbound_streams](https://docs.rs/libp2p-swarm/latest/libp2p_swarm/struct.SwarmBuilder.html#method.max_negotiating_inbound_streams) for inbound streams.
REVIEW_EOF
