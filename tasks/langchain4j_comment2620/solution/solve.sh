#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `langchain4j-bedrock/src/main/java/dev/langchain4j/model/bedrock/ConverseResponseFromStreamBuilder.java` (around line 47): @tenpigs267 hello，I found an exception may occur at this line because the tool use returns the parameters in chunks instead of a complete JSON object.
REVIEW_EOF
