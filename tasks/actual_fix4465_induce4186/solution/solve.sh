#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/loot-core/src/shared/transactions.ts`:

This pull request introduces the defect later reported as "[Bug]: Fatal Error - There was an unrecoverable error in the UI. Sorry!". The
problem a user observed, and its root cause:

### Verified issue does not already exist?

- [x] I have searched and found no existing issue

### What happened?

I'm currently running v25.2.1 on Chrome browser on Windows 11 desktop.

Clicked on "Expand/Collapse split transaction" button on top right after deleted an existing split transactions, the error message below pop up. "Reset budget cache" and "Repair transaction" in the setting did not help, I had to use mobile (Android) to recreate the split or delete the "parent" transaction to resolve the issue. 

Unable to access to the following 3 pages after the error appeared:

1. All accounts
2. On budget
3. Specific account where the split transaction occured

**Error Message:** 

Fatal Error
There was an unrecoverable error in the UI. Sorry!

TypeError: Cannot read properties of undefined (reading 'length') at x (http://localhost:5006/static/js/index.4_kdGSf3.js:269:43958) at L (http://localhost:5006/static/js/index.4_kdGSf3.js:89:206181) at WTe.render (http://localhost:5006/static/js/index.4_kdGSf3.js:89:190993) at Uk (http://localhost:5006/static/js/index.4_kdGSf3.js:49:6186) at VP (http://localhost:5006/static/js/index.4_kdGSf3.js:49:5982) at X8 (http://localhost:5006/static/js/index.4_kdGSf3.js:49:44939) at Y8 (http://localhost:5006/static/js/index.4_kdGSf3.js:49:39801) at vee (http://localhost:5006/static/js/index.4_kdGSf3.js:49:39728) at zx (http://localhost:5006/static/js/index.4_kdGSf3.js:49:39578) at Zk (http://localhost:5006/static/js/index.4_kdGSf3.js:49:35941)

### How can we reproduce the issue?

1. In a on budget account, create a split transaction (in my case, it was a two split), insert the category and value then save the transaction.
2. Select the split transaction (the childs) and delete them (parent transaction is not deleted).
3. Clicked on "Expand/Collapse split transaction" button on top right

### Where are you hosting Actual?

Locally via Yarn

### What browsers are you seeing the problem on?

Chrome

### Operating System

Windows 11

This same root cause must be fixed before merging.
REVIEW_EOF
