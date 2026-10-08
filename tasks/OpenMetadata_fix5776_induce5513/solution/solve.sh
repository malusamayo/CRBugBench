#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `openmetadata-ui/src/main/resources/ui/src/constants/services.const.ts`:

This pull request introduces the defect later reported as "`Connection Scheme` field missing from Ingestion UI". The
problem a user observed, and its root cause:

**Affected module**
UI

**Describe the bug**
`Connection Scheme` field missing from Ingestion UI

<img width="706" alt="image" src="https://user-images.githubusercontent.com/39544459/176612268-de7639b8-d046-4969-92ce-13bce9e0e2a5.png">

This same root cause must be fixed before merging.
REVIEW_EOF
