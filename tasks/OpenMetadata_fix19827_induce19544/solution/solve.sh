#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `openmetadata-ui/src/main/resources/ui/src/styles/components/rjsf.less`:

This pull request introduces the defect later reported as "Section heading not visible in the add/edit ingestion page". The
problem a user observed, and its root cause:

**Affected module**
Does it impact the UI, backend or Ingestion Framework?
UI

**Describe the bug**
A clear and concise description of what the bug is.

Section heading not visible in the add/edit ingestion page

**To Reproduce**

Screenshots or steps to reproduce

<img width="1512" alt="Image" src="https://github.com/user-attachments/assets/1b3c898b-ad2f-44bc-8e87-24f3770cd717" />

**Expected behavior**
A clear and concise description of what you expected to happen.

**Version:**
 - OS: [e.g. iOS]
 - Python version:
 - OpenMetadata version: [e.g. 0.8]
 - OpenMetadata Ingestion package version: [e.g. `openmetadata-ingestion[docker]==XYZ`]

**Additional context**
Add any other context about the problem here.

This same root cause must be fixed before merging.
REVIEW_EOF
