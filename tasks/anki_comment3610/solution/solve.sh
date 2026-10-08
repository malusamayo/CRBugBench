#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `ts/routes/deck-options/FsrsOptions.svelte` (around line 152): Is checking the number of fsrsItems in Svelte reliable (vs checking them in Rust)? Asking just because there was an issue in the past where Anki would report 0 reviews even when the preset had some.

See
- https://github.com/ankitects/anki/issues/3242
- https://github.com/ankitects/anki/pull/3591
REVIEW_EOF
