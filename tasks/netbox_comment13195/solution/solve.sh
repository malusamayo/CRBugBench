#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `netbox/extras/forms/model_forms.py` (around line 98): This does not account for Windows users who get CRLF instead of just LF.

```suggestion
        return self.cleaned_data['extra_choices'].replace('\r\n','\n').split('\n')
```
REVIEW_EOF
