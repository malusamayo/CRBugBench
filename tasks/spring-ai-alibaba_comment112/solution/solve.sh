#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `community/baidu-search-plugin-starter/src/main/java/com/alibaba/cloud/plugin/BaiduSearchPluginConfiguration.java` (around line 41): I guess here we misused `jdk.jfr.Description`, it should be `org.springframework.context.annotation.Description`.
REVIEW_EOF
