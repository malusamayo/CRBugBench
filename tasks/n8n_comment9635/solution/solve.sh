#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `packages/nodes-base/nodes/Twitter/V2/GenericFunctions.ts` (around line 88): This code does not account for query-params.

also, since `value` is expected to be a URL here, we **could** use `new URL` to parse the string to
1. validate that the hostname is either twitter.com or x.com (otherwise throw an error)
2. use extract the tweetId only from `url.pathname` and not from any other part of the url.
REVIEW_EOF
