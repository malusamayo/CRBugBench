#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `manim/mobject/svg/text_mobject.py` (around line 213): I think (although I am not 100% sure; CC @cobordism @leotrs) that the constructor of `SVGMobject` here should receive all input arguments from lines 142 to 148 (https://github.com/ManimCommunity/manim/pull/858/files#diff-1cf583cd8792705997f6ee46cd7118aa3d3d52513aeeaab03805586982f02b25R142-R148) as these (should) specify properties of the final Mobject.

Could you please try to add the ones from there that are not passed yet, as well as a `**kwargs` for all other keyword args? (As far as I can see, they are not processed anywhere else in `CairoText` and thus should be propagated.)
REVIEW_EOF
