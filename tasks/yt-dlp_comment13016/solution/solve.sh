#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `yt_dlp/extractor/playerfm.py` (around line 47): The input url may have a query or a fragment (or more path segments!), so we can't just add `.json` to it.

We'll want to use the `url` capture group added in my above suggestion:
```suggestion
        # podcast url is always after last backlash
        video_id, url = self._match_valid_url(url).group('id', 'url')
        data = self._download_json(url + '.json', video_id)
```
REVIEW_EOF
