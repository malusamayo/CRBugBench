#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `yt_dlp/extractor/crunchyroll.py` (around line 214): ```suggestion
        for locale, subtitle in traverse_obj(stream_response, (('subtitles', 'captions'), {dict.items}, ...)):
            subtitles.setdefault(locale, []).append(traverse_obj(subtitle, {'url': 'url', 'ext': 'format'}))
```
REVIEW_EOF
