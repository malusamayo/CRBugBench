#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `x-pack/plugin/core/src/main/java/org/elasticsearch/xpack/core/ml/inference/trainedmodel/FillMaskConfig.java` (around line 238): The logic here when a tokenization is not specified must match that in the constructor of the `FillMaskConfig` class:

```suggestion
            String tokenizationMaskToken = tokenization == null ? tokenization.createDefault().getMaskToken() : tokenization.getMaskToken();
```

But then, constructing the default tokenization for no reason is wasteful, this line should only be run if `maskToken != null`, which is very unlikely. So please restructure the `if` below into two so that this line can go in between them.
REVIEW_EOF
