#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `yt_dlp/cookies.py` (around line 163): since originAttributes still may contain other values (ref: https://searchfox.org/mozilla-central/source/caps/OriginAttributes.cpp#205-240), what about something like:
```suggestion
                cursor.execute(
                    'SELECT host, name, value, path, expiry, isSecure FROM moz_cookies WHERE NOT INSTR(originAttributes,"userContextId=")')
```
REVIEW_EOF
