#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `tools/releaseBuild/azureDevOps/templates/windows-package-signing.yml` (around line 50): ```suggestion
      tools/releaseBuild/generatePackgeSigning.ps1 -AuthenticodeFiles $authenticodeFiles -path "$(System.ArtifactsDirectory)\package.xml" -MsixCertType $env:MSIX_TYPE -MsixFiles $msixFiles
```
REVIEW_EOF
