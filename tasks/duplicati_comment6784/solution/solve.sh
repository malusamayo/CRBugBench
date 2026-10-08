#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `proprietary/DiskImage/Duplicati.Proprietary.DiskImage.csproj` (around line 24): The IsOSPlatform determines the build-host OS, not the target OS, so this will be excluded if we build for MacOS on a Windows host.

I prefer a separate folder with the `.c` file and a small shell script that builds the library for x64 and arm64. We can then include the binaries directly in Git, and it is then not a requirement to have `clang` to build the whole solution, only `dotnet`.
REVIEW_EOF
