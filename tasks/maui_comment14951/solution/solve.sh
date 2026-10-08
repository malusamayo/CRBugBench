#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/Controls/src/Core/Handlers/Items/iOS/ItemsViewController.cs` (around line 204): Should these take into account what comparison on line 188 caused you to get here?

I'm testing this in the controls gallery and the if statement on line 188 is true because

```C#
// 2708 != 2820
_previousContentSize.Height != contentSize.Height
```

But the invalidate gets triggered because the contentSize width is always less than the screenWidth

```C#
// 418 < 430  
contentSize.Width < screenWidth
```

Should the if be

```C#
if (_previousContentSize.Width != contentSize.Width && (contentSize.Width < screenWidth || contentSize.Width < screenWidth))
```
REVIEW_EOF
