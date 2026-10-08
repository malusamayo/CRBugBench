#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `yt_dlp/extractor/bilibili.py` (around line 656): This *needs* to be a dict; if we pass it as the `from_dict` argument and it's `None`, then we are joining literal strings of `title` and `sub_title` 
```suggestion
            high_level = traverse_obj(initial_state, ('elecFullInfo', 'show_info', 'high_level', {dict})) or {}
```
REVIEW_EOF
