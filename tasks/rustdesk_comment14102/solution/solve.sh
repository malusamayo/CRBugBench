#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/platform/macos.mm` (around line 328): `kCGEventOtherMouseDown/kCGEventOtherMouseUp` are missed, how about 

```
CGEventMask eventMask = (1 << kCGEventKeyDown) | (1 << kCGEventKeyUp) |
                        (1 << kCGEventLeftMouseDown) | (1 << kCGEventLeftMouseUp) |
                        (1 << kCGEventRightMouseDown) | (1 << kCGEventRightMouseUp) |
                        (1 << kCGEventOtherMouseDown) | (1 << kCGEventOtherMouseUp) |
                        (1 << kCGEventLeftMouseDragged) | (1 << kCGEventRightMouseDragged) |
                        (1 << kCGEventOtherMouseDragged) |
                        (1 << kCGEventMouseMoved) | (1 << kCGEventScrollWheel);
```
REVIEW_EOF
