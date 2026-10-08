#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/excalidraw/components/TTDDialog/TTDDialogInput.tsx`:

This pull request introduces the defect later reported as "[Bug]: TextToDiagram modal autoscrolls page to bottom". The
problem a user observed, and its root cause:

In v0.18.0, when you click on the "Mermaid to Excalidraw" TTD modal button, the page autoscrolls to the bottom. You have to scroll back to where to modal was opened.

This is easily reproduced in the docs demo:
https://docs.excalidraw.com/docs/@excalidraw/excalidraw/api/children-components/main-menu

See attached video.

https://github.com/user-attachments/assets/a10599a8-fad7-4c3b-b799-997dbc03d244

This same root cause must be fixed before merging.
REVIEW_EOF
