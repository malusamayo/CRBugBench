#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `netbox/dcim/forms/models.py` (around line 885): Sorry, missed this earlier when we discussed: This should have `query_params` on it too, to limit the locations by the selected site:

```python
        query_params={
            'site_id': '$site'
        }
```
REVIEW_EOF
