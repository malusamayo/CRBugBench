#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `openbb_platform/providers/yfinance/openbb_yfinance/models/equity_screener.py` (around line 116): If the value fails to parse as a Country, it likely is not a valid string. Instead of letting it through to the API call, we should validate the value against the list of accepted countries.

```suggestion
                country_code = v.strip().lower()
```

Without the raised ValueError, the user gets returned an EmptyDataError instead, which is missing the helpful message with the valid options.
REVIEW_EOF
