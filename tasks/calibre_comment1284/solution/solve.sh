#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/calibre/customize/ui.py` (around line 480): Should be _list_site_plugins()

2. In `src/calibre/customize/ui.py` (around line 693): Should catch OSError not just FileNotFoundError

3. In `src/calibre/customize/ui.py` (around line 734): There needs to be support for BLACKLISTED_PLUGINS for system-wide plugins as well. Also, in add_plugin() you have disabled the ability to ad dplugins whose names conflict with system plugins, however, this code prioritizes installed plugins over system plugins.
REVIEW_EOF
