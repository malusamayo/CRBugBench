#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/Compilers/CSharp/Portable/Symbols/Source/SourceMemberFieldSymbol.cs` (around line 577): >CheckAllConstraints [](start = 17, length = 19)

This call is a substitute for the check that would be performed in `Binder.ConstructNamedType` if not suppressed. That check uses `conversions.WithNullability(true)` if the nullable feature is enabled.
REVIEW_EOF
