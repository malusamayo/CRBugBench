#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `GitExtensions/Project.Publish.targets` (around line 119): GitExtensions -> C:\dev\gc\gitextensions\artifacts\Debug\bin\GitExtensions\net
5.0-windows\GitExtensions.dll
C:\dev\gc\gitextensions\GitExtensions\Project.Publish.targets(114,5): error MSB4
044: The "_GetPluginAssembliesCodeTask" task was not given a value for the requi
red parameter "IsContinuousIntegrationBuild". [C:\dev\gc\gitextensions\GitExtens
ions\GitExtensions.csproj]
REVIEW_EOF
