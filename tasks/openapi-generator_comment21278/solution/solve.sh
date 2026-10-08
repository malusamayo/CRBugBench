#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `modules/openapi-generator/src/test/resources/3_1/issue_21051.yaml` (around line 1): thanks for the pr.

i did a test with this test spec but got compilation errors

```
[INFO] Compiling 5 source files to C:\Users\wing3\AppData\Local\Temp\defaultvalue\target\test-classes
[INFO] -------------------------------------------------------------
[ERROR] COMPILATION ERROR :
[INFO] -------------------------------------------------------------
[ERROR] C:\Users\wing3\AppData\Local\Temp\defaultvalue\src\test\java\org\openapitools\client\model\TestTest.java:[34,31] error: Test is abstract; cannot be instantiated

```

is that expected?
REVIEW_EOF
