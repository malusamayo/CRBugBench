#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `ToolBox/LeanDataWriter.cs` (around line 487): `Compression.ZipCreateAppendData` won't update the entry if it already exists and log an error and return `false`. Believe this can happen if calling `Write(IEnumerable<BaseData> source)`, they don't seem to be removing the entry if it exists as `DownloadAndSave()` is, this seems in part to the code duplication we have here 😅  - Maybe we can add an override argument to `Compression.ZipCreateAppendData`. Thoughts @Jay-Jay-D
Think we are missing some tests for covering this behavior too 😢
REVIEW_EOF
