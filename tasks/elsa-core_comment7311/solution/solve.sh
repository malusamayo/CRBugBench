#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/modules/Elsa.Workflows.Runtime/Distributed/WorkflowDefinitionsRefresherDistributedLocking.cs` (around line 34): We should not wait for one minute before giving up on acquiring a lock, because we want to try and acquire a lock right now - if that doesn't succeed, it mean another replica has the lock, therefore we can just exit immediately.


```suggestion
            TimeSpan.Zero,
```
REVIEW_EOF
