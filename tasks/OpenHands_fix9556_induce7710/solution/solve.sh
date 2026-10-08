#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `frontend/src/components/features/settings/delete-api-key-modal.tsx`:

This pull request introduces the defect later reported as "[Bug]: [OpenHands Cloud] The Delete API Key modal does not display correctly if the API key name is too long.". The
problem a user observed, and its root cause:

### Is there an existing issue for the same bug? (If one exists, thumbs up or comment on the issue instead).

- [x] I have checked the existing issues.

### Describe the bug and reproduction steps

**Description:**  
In **OpenHands Cloud**, the Delete API Key modal does not display correctly when an API key has an excessively long name.

---

### ✅ Expected Behavior
- the Delete API Key modal should render properly, regardless of the length of the API key name.

---

### ❌ Current Behavior
- the Delete API Key modal layout breaks or displays incorrectly when an API key has a long name.

---

### 🔁 Steps to Reproduce
1. Navigate to the **API Keys** page.
2. Create a new API key with a very long name.
3. Click on the **Delete** action.
4. Observe the Delete API Key modal layout.
---

### 📹 Additional Context
An image demonstrating the issue can be found here:  


<img width="1432" alt="Image" src="https://github.com/user-attachments/assets/a3d7fed4-117f-432e-b802-ec4c28a89ccb" />

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
