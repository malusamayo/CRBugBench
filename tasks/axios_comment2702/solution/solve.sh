#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `lib/core/Axios.js` (around line 99): Here requires to notice,

- The order of request interceptors is reversed. Shall we keep sync and async the same?
- Once there is an error, let's break the loop. And for async chain, it is strange that the error handle can't catch errors from the success handler of the same interceptor, due to `then(f1, f2)` reason.

2. In `lib/core/Axios.js` (around line 97): Add a try/catch wrapper. We don't know what happens in `dispatchRequest`.
I felt a little understand why you check cancelled request before. But inside it, maybe somewhere like `transformRequest` can also throw an error.
REVIEW_EOF
