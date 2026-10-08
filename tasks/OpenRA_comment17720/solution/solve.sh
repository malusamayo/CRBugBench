#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `OpenRA.Mods.Cnc/UtilityCommands/LegacyTilesetImporter.cs` (around line 68): Maybe I'm missing something, but there's no `Extensions` field in bleed's `TileSet` code...?
REVIEW_EOF
