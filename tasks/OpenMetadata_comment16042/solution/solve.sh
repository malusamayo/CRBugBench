#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `.github/workflows/maven-build.yml` (around line 108): This will not work! Please refer to the [github actions workflow syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)!

Github does not provide out of box way to retry a step :(  You might want to look for [github actions from marketplace](https://github.com/marketplace?type=actions)!
REVIEW_EOF
