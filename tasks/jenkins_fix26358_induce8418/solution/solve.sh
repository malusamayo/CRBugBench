#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/main/js/util/keyboard.js`:

This pull request introduces the defect later reported as "Dropdown menu doesn't scroll when navigating with keyboard". The
problem a user observed, and its root cause:

### Jenkins and plugins versions report

<details>
  <summary>Environment</summary>

  <!-- Paste your environment details below -->
  ```text
Jenkins 2.552-SNAPSHOT
OS: Ubuntu 24.04
Java: 21.0.10 - Ubuntu (OpenJDK 64-Bit Server VM)
  ```

</details>


### What Operating System are you using (both controller, and any agents involved in the problem)?

Ubuntu 24.04.4 LTS

### Reproduction steps

1. Start Jenkins
2. Goto Manage Jenkins page
3. Click on Manage Jenkins dropdown menu
4. Press arrow down key repeatedly to navigate through items
Attaching video for reference:

https://github.com/user-attachments/assets/486b9e34-92b7-45b6-a4f8-6ec9dcd9a4f8


### Expected Results

Dropdown should scroll automatically to keep the currently selected item visible when navigating with arrow keys.

### Actual Results

The dropdown doesn't scroll. Items beyond the visible area get selected but stay off-screen, so there's no visual feedback on what's selected.

### Anything else?

_No response_

### Are you interested in contributing a fix?

Yes

This same root cause must be fixed before merging.
REVIEW_EOF
