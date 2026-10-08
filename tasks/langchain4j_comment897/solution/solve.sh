#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `langchain4j-anthropic/src/main/java/dev/langchain4j/model/anthropic/AnthropicMapper.java` (around line 129): This unfortunately breaks the cases where GSON is not used (like Quarkus which swaps the JSON handling for Jackson in the supported modules).
REVIEW_EOF
