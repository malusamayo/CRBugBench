#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/VisualStudio/Core/Def/PackageRegistration.pkgdef` (around line 20): typo: 
```suggestion
"UIContexts"="CA719A03-D55C-48F9-85DE-D934346E7F70;EEC3DF0D-6D3F-4544-ABF9-8E26E6A90275"
```
REVIEW_EOF
