#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `scripts/validate_min_versions_in_sync.py` (around line 21): you'll need to add `pyyaml` to `additional_dependencies` here

https://github.com/pandas-dev/pandas/blob/7b3f50a4208effba973b6b6032e0b9a1ced06eed/.pre-commit-config.yaml#L395-L400
REVIEW_EOF
