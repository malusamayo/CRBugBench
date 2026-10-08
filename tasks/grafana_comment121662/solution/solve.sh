#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `pkg/registry/apis/iam/team_search.go` (around line 363): Nit: we should probably also validate non-numeric `teamId` at the handler level to return a 400 instead of 500 in the downstream integer parsing 
```suggestion
       for _, v := range teamIds {
               if _, err := strconv.ParseInt(v, 10, 64); err != nil {
                       http.Error(w, fmt.Sprintf("invalid teamId value %q: must be an integer", v), http.StatusBadRequest)
                       return
               }
       }
```
REVIEW_EOF
