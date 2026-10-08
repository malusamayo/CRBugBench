#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/Files.App/UserControls/StatusBarControl.xaml` (around line 198): I think this one should be 
```suggestion
							ToolTipService.ToolTip="{x:Bind Commands.OpenRepoInVSCode.LabelWithHotKey, Mode=OneWay}"
```
REVIEW_EOF
