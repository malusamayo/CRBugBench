#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `eng/ProjectReferences.props` (around line 13): Hmm I think you're still missing some pieces. 
```
F:\workspace\_work\1\s\eng\targets\ResolveReferences.targets(212,5): error MSB3245: Could not resolve this reference. Could not locate the package or project for "dotnet-getdocument". Did you update baselines and dependencies lists? See docs/ReferenceResolution.md for more details. [F:\workspace\_work\1\s\src\Mvc\Extensions.ApiDescription.Server\src\Microsoft.Extensions.ApiDescription.Server.csproj]

```
REVIEW_EOF
