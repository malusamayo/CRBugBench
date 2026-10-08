#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `crates/bevy_text/src/draw.rs` (around line 124): ```suggestion
                    let y = -bounds.max.y + glyph_height / 2.0 - scaled_font.descent() + 0.5;
```
REVIEW_EOF
