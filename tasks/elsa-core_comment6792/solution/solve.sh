#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/modules/Elsa.Workflows.Management/Contracts/IWorkflowReferenceQuery.cs` (around line 6): in the implementation of this  we should prevent loading of workflow definition ids that were already being loaded for 2 reasons 

- performance 
- circular referencing
REVIEW_EOF
