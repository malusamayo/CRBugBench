#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `mitmproxy/contentviews/__init__.py` (around line 134): It looks like our test coverage is bad here because this is not caught, but this will break a few contentviews which currently do simple string comparisons. 

Can you pull the full content type header from `http_message.headers` in the multipart contentview instead? (http_message is passed as part of in `**metadata`). Thanks!
REVIEW_EOF
