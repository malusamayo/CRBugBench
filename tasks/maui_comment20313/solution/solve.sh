#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/Controls/src/Core/DispatcherExtensions.cs` (around line 31): ```suggestion
				if (appMauiContext.Services.GetOptionalApplicationDispatcher() is IDispatcher appDispatcherServiceDispatcher)
					return appDispatcherServiceDispatcher;
```

The app dispatcher is overrideable by using keyed services, so we need to make sure we check that too. The GetOptionalApplicationDispatcher method does this.
REVIEW_EOF
