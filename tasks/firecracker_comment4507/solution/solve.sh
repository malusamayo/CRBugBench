#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `.buildkite/common.py` (around line 98): ```suggestion
    if os.environ.get("BUILDKITE_PULL_REQUEST", "false") == "false":
```

it will only be `None` if the function is executed outside of buildkite altogether. If its executed by a buildkite pipeline, yet not on a PR, then it will be the string `"false"` [[1]]

[1]: https://buildkite.com/docs/pipelines/environment-variables#BUILDKITE_PULL_REQUEST
REVIEW_EOF
