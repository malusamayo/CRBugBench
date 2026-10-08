#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `packages/@n8n/nodes-langchain/nodes/agents/Agent/agents/ToolsAgent/execute.ts` (around line 356): Let's keep the new-lines from the original version here. Otherwise the formatting_instructions are merged together with the system message:
![CleanShot 2025-04-07 at 15 15 30](https://github.com/user-attachments/assets/7ce79aad-e321-4793-b708-858cd8519ffd)
REVIEW_EOF
