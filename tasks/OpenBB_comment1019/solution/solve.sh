#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `gamestonk_terminal/stocks/sector_industry_analysis/financedatabase_view.py` (around line 76): For cases like this one
![image](https://user-images.githubusercontent.com/11668535/144764471-8f43feaf-2bb2-4df2-a106-4d521a287d78.png)
I think that it fails here if a metric for a company is not available in the database. Should we add a check and a human-readable error message?
REVIEW_EOF
