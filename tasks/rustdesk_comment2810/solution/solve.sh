#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/ui_interface.rs` (around line 246): Honestly, `crate::get_custom_rendezvous_server(get_option_("custom-rendezvous-server")).is_empty()` has bug, you last change fixed the bug, but we need to get rid of duplication.
REVIEW_EOF
