#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `netbox/extras/forms/bulk_import.py` (around line 101): We also need to normalize any escaped colons (`\:`) when saving the data.
```suggestion
                value = value.replace('\:', ':')
                label = label.replace('\:', ':')
                data.append((value, label))
```

(This should also be applied to the model form for #14467.)
REVIEW_EOF
