#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `packages/loot-core/src/server/accounts/sync.ts` (around line 792): Especially now, I feel like this if/else can be simplified down to straight logic with no branch.

Have a var `const hasStartDate = startDate !== null` and then most of the code is the same in both paths.  The true/false last argument for GoCardless just becomes `!hasStartDate` and similarly the process call at the end passes in `!hasStartDate`.

That also fixes a bug I spotted where there is no else branch in the bottom portion, so if the account sync source is not SF or GC it will just go on and try to process.
REVIEW_EOF
