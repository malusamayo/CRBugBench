#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `tools/enumerate-tests.ts`:

This pull request introduces the defect later reported as "yarn build-deps under tfjs-backend-webgpu failed". The
problem a user observed, and its root cause:

With https://github.com/tensorflow/tfjs/pull/5416 applied. There are still two issues when run yarn build-deps under tfjs-backend-webgpu on Windows:
1. The command line is too long
```
ERROR: /build/tfjs/tfjs-core/src/BUILD.bazel:44:16: Action tfjs-core/src/tests.ts failed: (Exit 1): enumerate_tests_bin.bat failed: error executing command bazel-out/host/bin/tools/enumerate_tests_bin.bat -r tfjs-core/src -o bazel-out/x64_windows-fastbuild/bin/tfjs-co
re/src/tests.ts tfjs-core/src/browser_util_test.ts tfjs-core/src/buffer_test.ts ... (remaining 244 argument(s) skipped)
The command line is too long.
Target //tfjs-core:tfjs-core_pkg failed to build
Use --verbose_failures to see the command lines of failed build steps.
```
2.  There is a typo here:
```
+++ b/link-package/package.json
@@ -6,7 +6,7 @@
   "license": "Apache 2.0",
   "private": true,
   "scripts": {
-    "build": "yarn build-backend-cpu && yarn build-backend-webgo && yarn build-core && yarn build-tflite && yarn reinstall",
+    "build": "yarn build-backend-cpu && yarn build-backend-webgl && yarn build-core && yarn build-tflite && yarn reinstall",
```

This same root cause must be fixed before merging.
REVIEW_EOF
