#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `pydantic/_internal/_core_utils.py` (around line 603): ```suggestion
    if os.getenv('PYDANTIC_VALIDATE_CORE_SCHEMAS'):
```

nit: this follows the same logic for `PYDANTIC_PRIVATE_ALLOW_UNHANDLED_SCHEMA_TYPES` and how CPython handles environment variables (it just checks for the present of the environment variable)
REVIEW_EOF
