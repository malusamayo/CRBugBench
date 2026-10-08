#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `extensions/wikibase/tests/src/org/openrefine/wikibase/operations/PerformWikibaseEditsOperationTest.java` (around line 80): We'll need to make sure the old format of such Change objects can still be deserialized correctly, so that operations run with previous versions of OpenRefine can still be done and undone correctly. So there should be two tests: the current one (unchanged) and another one for the new format.

To make this backwards compatibility simpler, I would recommend using two separate maps (one for the entity ids, one for the names) instead of storing pairs of values in maps. It's probably worth updating the Java types accordingly.
REVIEW_EOF
