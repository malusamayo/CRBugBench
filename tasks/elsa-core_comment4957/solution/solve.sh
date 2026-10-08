#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/modules/Elsa.Workflows.Management/Filters/WorkflowInstanceFilter.cs` (around line 120): One of the properties of **TimestampFilter** can be null and have a bug for Eg:
with : 
?TimestampFilters=[{ "CreatedAt", "Operator": 1, "Timestamp": "2024-02-16T00:00:00"}]
REVIEW_EOF
