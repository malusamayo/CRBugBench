#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/EFCore/Metadata/MemberClassifier.cs` (around line 78): For non-collection navigations `elementType` should be `null`. The callers need to be adjusted to use `memberInfo.GetMemberType()` in that case
REVIEW_EOF
