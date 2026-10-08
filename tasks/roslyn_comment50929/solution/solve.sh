#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/Features/LanguageServer/Protocol/Handler/RequestExecutionQueue.cs` (around line 212): I think this is problematic -if a didChange/Open/Close comes for not the 'main' workspace (and we're not looking up which solution/workspace it belongs to), then we're not clearing the cache.  

I can think of two possible answers
1.  We just clear all workspaces
2.  We need to lookup and store the workspace for mutating requests, even if we don't actually fork the solution
REVIEW_EOF
