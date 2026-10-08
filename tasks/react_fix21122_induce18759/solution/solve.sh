#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/react-reconciler/src/ReactFiberWorkLoop.new.js`:

This pull request introduces the defect later reported as "flushSync should change priority of commit phase updates to sync, even though it can't flush them immediately". The
problem a user observed, and its root cause:

flushSync early returns if it detects it's in the commit (or render) phase, since it can't synchronously flush when React is already working.

However, it should still change the priority of updates scheduled by the callback to be synchronous.

This mostly already works because the commit phase itself has a sync event priority context, but the passive effect phase doesn't.

Need more tests for this.

This same root cause must be fixed before merging.
REVIEW_EOF
