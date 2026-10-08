#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/Microsoft.ML.Experimental/DataLoadSave/Database/DatabaseLoaderCursor.cs` (around line 167): For strings, this type is usually `typeof(ReadOnlyMemory<char>)`. ML.NET uses `ROM<char>` everywhere in order to support sub-strings and not having to allocate each individual string.

We should be sure to add a test for strings to cover this. #Closed
REVIEW_EOF
