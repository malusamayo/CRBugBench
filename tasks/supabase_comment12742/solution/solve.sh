#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `apps/docs/pages/guides/auth/quickstarts/react.mdx` (around line 97): Thoughts on unsubscribing in the `useEffect`'s cleanup function?
```suggestion
            const {
              data: { subscription },
            } = supabase.auth.onAuthStateChange((_event, session) => {
              setSession(session)
            })
            
            return () => subscription.unsubscribe()
```
REVIEW_EOF
