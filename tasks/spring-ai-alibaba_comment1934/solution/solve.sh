#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `auto-configurations/spring-ai-alibaba-autoconfigure-memory/src/main/java/com/alibaba/cloud/ai/autoconfigure/memory/redis/JedisRedisChatMemoryConnectionConfiguration.java` (around line 40): I think `matchIfMissing` should be set to false here; otherwise, if the user hasn't configured this field and meet all other conditions, there will be three `AutoConfiguration` classes active at the same time.
REVIEW_EOF
