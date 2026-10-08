#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `frontend/src/components/features/settings/secrets-settings/secret-list-item.tsx`:

This pull request introduces the defect later reported as "[Bug]: The secret settings layout will be broken if the secret name is too long.". The
problem a user observed, and its root cause:

### Is there an existing issue for the same bug? (If one exists, thumbs up or comment on the issue instead).

- [x] I have checked the existing issues.

### Describe the bug and reproduction steps

**Description:**

The layout of the Secret Settings page breaks when a secret with an excessively long name is added.

---

**Steps to Reproduce:**

1. Navigate to the **Secret Settings** page.  
2. Create a new secret with a **very long name**.

---

**Current Behavior:**

- The layout of the Secret Settings page becomes distorted or broken when displaying the long secret name.

---

**Expected Behavior:**

- The layout should remain intact and responsive, regardless of the length of the secret name.

---

**Additional Information:**

- 📹 A video demonstrating the issue:  
 
https://github.com/user-attachments/assets/7926a4d1-e94c-46e1-bb74-f9cfd7cb0e28

### OpenHands Installation

Docker command in README

### OpenHands Version

_No response_

### Model Name

_No response_

### Operating System

None

### Logs, Errors, Screenshots, and Additional Context

N/A

This same root cause must be fixed before merging.
REVIEW_EOF
