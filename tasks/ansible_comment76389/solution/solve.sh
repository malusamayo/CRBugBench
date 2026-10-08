#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `lib/ansible/plugins/become/sudo.py` (around line 97): This could cause issues if there is anything in the args that might be a path with a space in it.  I'd really suggest using `shlex.split` instead, which will respect any quoting.  I think spliting into a list via `shlex.split`, and then rejoining will ultimately be the most safe.
REVIEW_EOF
