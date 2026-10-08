#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `candle-transformers/src/models/t5.rs` (around line 351): This doesn't seem right to me for the case where `use_cache=true` and the query size is larger than 1 (typically the case when processing a prompt). I would think it's more something like `kv_len - q_len` to `kv_len`?
REVIEW_EOF
