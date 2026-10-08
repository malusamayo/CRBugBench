#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/sinks/datadog/traces/apm_stats/flusher.rs` (around line 70): I think we should also be breaking here? If the tripwire signal is terminal (i.e. we `break`) when sent correctly, we would conceivably want to shutdown if the tripwire channel was closed: it's not like it's gonna actually ever _come back_.
REVIEW_EOF
