#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `dotnet/src/Extensions/Planning.StepwisePlanner/StepwisePlanner.cs` (around line 51): This `EmbeddedResource` should only be read from file if the `promptUserConfig` arg was not passed in.
REVIEW_EOF
