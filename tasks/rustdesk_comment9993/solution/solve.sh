#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `flutter/lib/models/file_model.dart` (around line 524): 1. If `emptyDirs` is empty, dothing, otherwise there will be a empty directory whose name is the same as the current item path. After changing this, tests between win&win, win&linux, linux&linux, win&andrioid are good.
2. Add version check for remote to local:
```
if (versionCmp(rootState.target!.ffiModel.pi.version, '1.3.3') < 0) {
      return;
    }
```
3. Remove changes in `pubspec.lock` and code format in `message.proto`.
4. There will be creating folder logs in connection manager, but it's ok.
REVIEW_EOF
