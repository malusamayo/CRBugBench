#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `tfjs-layers/src/layers/preprocessing/center_crop.ts`:

This pull request introduces the defect later reported as "regression: unresolvable imports". The
problem a user observed, and its root cause:

PR #6875 added code in `tfjs-layers/src/layers/preprocessing/center_crop.ts`

```js
import {resizeBilinear} from '@tensorflow/tfjs-core/ops/image/resize_bilinear';
import {cropAndResize} from '@tensorflow/tfjs-core/ops/image/crop_and_resize';
```

how is this import supposed to be resolved?  
i cannot get a clean build of `tfjs` due to this. and it goes against all other import syntax used.

```log
src/tfjs-layers/src/layers/preprocessing/center_crop.ts:13:30 - error TS2307: Cannot find module '@tensorflow/tfjs-core/ops/image/resize_bilinear' or its corresponding type declarations.
```

cc @AdamLang96 @mattsoulanille

This same root cause must be fixed before merging.
REVIEW_EOF
