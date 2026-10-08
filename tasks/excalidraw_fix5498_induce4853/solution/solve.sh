#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `scripts/prebuild.js`:

This pull request introduces the defect later reported as "prebuild fails (missing service-worker)". The
problem a user observed, and its root cause:

```
node ./scripts/prebuild.js
/home/diadem/Projects/excalidraw/scripts/prebuild.js:12
      throw error;
      ^

[Error: ENOENT: no such file or directory, rename './public/service-worker.js' -> './src/service-worker.js'] {
  errno: -2,
  code: 'ENOENT',
  syscall: 'rename',
  path: './public/service-worker.js',
  dest: './src/service-worker.js'
}
```

This same root cause must be fixed before merging.
REVIEW_EOF
