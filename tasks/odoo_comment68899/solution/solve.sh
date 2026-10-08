#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `addons/project/views/project_update_templates.xml` (around line 57): ```suggestion
                <t t-if="milestones['created']">
```
Should not it be this ? If not, why not put the content of this t tag into the same t tag above (line 45) ?
REVIEW_EOF
