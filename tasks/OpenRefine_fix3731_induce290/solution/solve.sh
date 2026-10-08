#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `main/webapp/modules/core/scripts/views/data-table/cell-ui.js`:

This pull request introduces the defect later reported as "Preview & View services amputate ids with a hash character "#" ". The
problem a user observed, and its root cause:

### To Reproduce
Configure a reconciliation service that returns URIs as IDs. 

Hovering over reconciliation suggestions,  automatically matched values and manually mapped values will fail to retrieve the preview information as ID contained in the callback is truncated.

This same root cause must be fixed before merging.
REVIEW_EOF
