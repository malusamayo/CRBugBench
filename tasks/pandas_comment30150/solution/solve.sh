#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `pandas/_libs/missing.pyx` (around line 349): this is exceeds np.int32 max so on int32 platforms this doesn't work.

```
In [7]: 2 ** 61 - 1                                                                                                                                       
Out[7]: 2305843009213693951

In [8]: np.iinfo(np.int32).max                                                                                                                            
Out[8]: 2147483647

```
REVIEW_EOF
