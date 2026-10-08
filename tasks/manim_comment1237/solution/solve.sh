#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `manim/cli/render/commands.py` (around line 165): looking at https://pypi.org/pypi/manim/json it seems it is better to directly pick version from info rather than doing this

```suggestion
        try:
            releases = req_info.json()["info"]["version"]

            if releases != __version__:
```
REVIEW_EOF
