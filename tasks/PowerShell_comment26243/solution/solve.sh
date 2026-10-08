#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `.github/workflows/xunit-tests.yml` (around line 52): @copilot the log files are at ` /home/runner/work/PowerShell/PowerShell/xUnitTestResults.xm`
REVIEW_EOF
