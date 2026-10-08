#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `lib/helpers/formDataToJSON.js` (around line 31): The bracket alternative can scan to the end from each unmatched `[` and causes quadratic behaviour on malformed field names - replace with a linear tokeniser or a fail-fast grammar, and add regression coverage for long malformed bracket input.

The new grammar also allows `.` and `[` inside bracket-captured segments, while the new comment says path segments exclude `., [,` and `]` - define the intended grammar and cover cases like `foo[bar.baz]`.
REVIEW_EOF
