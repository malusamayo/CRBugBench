#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `docker/main/rootfs/usr/local/nginx/templates/base_path.gotmpl` (around line 14): This proxies to the unauthenticated port which will be removed in a future version. We would want this to be 8971 which will get complicated since the user may or may not have TLS enabled.

```suggestion
  proxy_pass http://127.0.0.1:8971/;
```
REVIEW_EOF
