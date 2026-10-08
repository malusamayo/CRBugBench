#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `langchain4j-dashscope/src/main/java/dev/langchain4j/model/dashscope/QwenHelper.java` (around line 374): This does not seem right, `toolSpecification.parameters()` is already handled above.

We should keep `toolSpecification.parameters()` support for backwards-compatibility
REVIEW_EOF
