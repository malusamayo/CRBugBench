#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `osu.Game/Rulesets/Objects/BarLineGenerator.cs` (around line 42): it's not guaranteed that an `EffectControlPoint` will be at the same point in time as the `TimingControlPoint`. Also, this is quite inefficient.

You can use `beatmap.ControlPointInfo.EffectPointAt` to avoid these two issues:

https://github.com/ppy/osu/blob/31a447fda0532fcf15f8c8251ca890c533386492/osu.Game/Beatmaps/ControlPoints/ControlPointInfo.cs#L58
REVIEW_EOF
