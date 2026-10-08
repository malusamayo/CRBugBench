#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `pkg/services/authz/zanzana/server/reconciler/reconciler.go` (around line 234): `GetStore()` returns an error when the store isn't found `(return nil, fmt.Errorf("store not found"))` so we never issue a reconciliation for an non-existant namespace.
REVIEW_EOF
