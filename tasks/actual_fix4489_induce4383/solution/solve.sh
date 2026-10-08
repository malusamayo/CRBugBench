#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/loot-core/src/shared/util.ts`:

This pull request introduces the defect later reported as "[Bug]: Reconciling Loan Account Taking Negative Balance as Positive". The
problem a user observed, and its root cause:

### Verified issue does not already exist?

- [x] I have searched and found no existing issue

### What happened?

I just updated to new release 25.3.0.
I do NOT use any bank sync features.
I don't do a split principal/interest payment when logging loan payments

As part of my EOM process, I go through all of my accounts and reconcile balances. For my loan accounts, I have run into an issue that was not happening on previous versions. After I hit the reconcile button, I enter my actual principal balance as a negative number, but when asking if I want to create a reconciliation transaction to balance the account it is taking the amount as positive. So, instead of a ~$100 transaction to account for interest, it asking me to create a ~$30,000 transaction to bring my account positive. Note that this issue doesn't seem to occur as long as you do not edit the amount in the reconcile box.

### How can we reproduce the issue?

Create a loan account with a balance. Click the Reconcile button, and enter an amount that is different than the loan balance so that the system needs to calculate a reconciliation transaction.

Step 1
![Image](https://github.com/user-attachments/assets/2854abd7-a3fb-4d78-a976-db87b140f435)
Step 2
![Image](https://github.com/user-attachments/assets/f43b282b-55a1-4460-a875-c22853e5d627)
Step 3
![Image](https://github.com/user-attachments/assets/8e792a36-f895-4605-ad57-7a7a2c77ea0e)

### Where are you hosting Actual?

Docker

### What browsers are you seeing the problem on?

Chrome

### Operating System

Windows 11

This same root cause must be fixed before merging.
REVIEW_EOF
