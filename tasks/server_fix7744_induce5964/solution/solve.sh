#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Api/Auth/Controllers/AccountsController.cs`:

This pull request introduces the defect later reported as "[PM-37182] Resend "New Device Login Protection" email doesn't work". The
problem a user observed, and its root cause:

### Steps To Reproduce

Precondition: Have any 2FA disabled for your BW account and the "New Device Login Protection" (NDLP) activated. And use an "unknown device" or incognito browser window for the following now (to trigger NDLP):

1. Go to https://vault.bitwarden.com
2. Log in with your email and master password.
3. The automatic NDLP email gets through (though console shows error 400).
4. Click on 'Resend'.


### Expected Result

I should get another email (and no error message in the console?!).

### Actual Result

I don't get another email (and the console throws error "401 Unauthorized").

### Screenshots or Videos

To make it unambiguous: I'm talking about emails containing verification codes in the context of: https://bitwarden.com/help/new-device-verification/

<img width="1920" height="1057" alt="Image" src="https://github.com/user-attachments/assets/8e86c464-5052-4321-8162-d786f12c4766" />

### Additional Context

I created that BW account only for testing this and will delete it. (so no worries about privacy / redactions)

PS: And I read about that issue with the resend button for the first time here: https://www.reddit.com/r/Bitwarden/s/994fV4fE9O

### Operating System

Windows

### Operating System Version

11 Home 25H2 Build 26200.8328

### Web Browser

Vivaldi

### Browser Version

7.9.3970.64 (Official Build) (64-bit)

### Build Version

2026.4.2 (BW US cloud account)

### Issue Tracking Info

- [x] I understand that work is tracked outside of Github. A PR will be linked to this issue should one be opened to address it, but Bitwarden doesn't use fields like "assigned", "milestone", or "project" to track progress.

This same root cause must be fixed before merging.
REVIEW_EOF
