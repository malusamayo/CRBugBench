#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `yt_dlp/extractor/facebook.py` (around line 397): `..., ...` seems maybe too lax for the first traversal path? i.e. it could branch out and return the wrong dict instead of falling back to the other `get_first`s. Is all that branching necessary? Or can we be more specific?

If you think we need `..., ...`, suggestion:
```suggestion
            uploader_data = (
                get_first(post, (..., ..., lambda k, v: k == 'owner' and v['name']))
                or get_first(media, ('owner', {dict}))
                or get_first(post, ('node', 'actors', ..., {dict})) or {})
```
REVIEW_EOF
