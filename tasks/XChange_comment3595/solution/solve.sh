#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `xchange-stream-gemini/src/main/java/info/bitrich/xchangestream/gemini/dto/GeminiOrderbook.java` (around line 18): why are you downgrading this do `Double`?

`level.getPrice().doubleValue()` can lead to lost precision

leave `BigDecimal`
REVIEW_EOF
