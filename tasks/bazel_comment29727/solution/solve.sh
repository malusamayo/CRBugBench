#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/main/java/com/google/devtools/build/lib/analysis/platform/ConstraintSettingInfo.java` (around line 121): Yes, adding `.toString()` fixes the build (sorry for not testing previously).

```
printer.append(", refines_constraint_value=").append(refinedConstraintValue.label().toString());
```
REVIEW_EOF
