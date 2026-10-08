#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/requests/packages.py` (around line 28): ```suggestion
        imported_mod = sys.modules[mod]
        sys.modules[f"requests.packages.{mod}"] = imported_mod
        mod = mod.replace(target, "chardet")
        sys.modules[f"requests.packages.{mod}"] = imported_mod
```
REVIEW_EOF
