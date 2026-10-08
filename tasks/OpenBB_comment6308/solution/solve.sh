#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `openbb_platform/core/openbb_core/app/model/field.py` (around line 22): This will force `choices=None` when no choices are provided, which pollutes the resulting pydantic model schema of the function signature. Instead, we should do the following: 
```suggestion
        """Initialize OpenBBField."""
        json_schema_extra = {"choices": choices} if choices else None
        super().__init__(
            description=description, json_schema_extra=json_schema_extra
        )
```

cc @montezdesousa
REVIEW_EOF
