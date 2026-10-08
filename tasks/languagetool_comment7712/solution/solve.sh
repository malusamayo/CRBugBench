#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `languagetool-server/src/main/java/org/languagetool/server/TextChecker.java` (around line 592): I don't think appending all ranges together here is correct when checking the text, since these could be distinct sentences separated by text in other languages; this might lead to e.g. false positives from text-level rules.
REVIEW_EOF
