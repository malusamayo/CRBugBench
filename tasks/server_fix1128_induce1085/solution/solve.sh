#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `scripts/bitwarden.sh`:

This pull request introduces the defect later reported as "Typo in bitwarden.sh". The
problem a user observed, and its root cause:

Hi,
 
I wanted to renew my cert manually today and ./bitwarden.sh renewcert always told me "Unknown command."
Seems like there is a typo in Line 138 of the bitwarden.sh script. (should be "renewcert" instead of "renewcrt" i guess)

Reference:
https://github.com/bitwarden/server/blob/6d8e37ebf634ef73ba7e99f26ef60ffacb59d74e/scripts/bitwarden.sh#L138

Kind regards

This same root cause must be fixed before merging.
REVIEW_EOF
