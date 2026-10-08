#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Aspire.Dashboard/Model/Interaction/InputViewModel.cs`:

This pull request introduces the defect later reported as "Can't select existing resource group from Azure provisioning (run mode) prompt". The
problem a user observed, and its root cause:

When running an apphost with an Azure resource that requires provisioning, the "Azure provisioning" dialog in the dashboard gets into a state that one can't proceed if an existing resource group is selected, because the "Location" field is disabled, but required, but not populated:

<img width="820" height="647" alt="Image" src="https://github.com/user-attachments/assets/9af17573-f4c2-4e8e-b774-89c885bc0ce4" />

Using version 13.3.0

This same root cause must be fixed before merging.
REVIEW_EOF
