#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/desktop-client/src/components/accounts/Account.tsx`:

This pull request introduces the defect later reported as "[Bug]: Run Rules in All Accounts view leads to "Something internally went wrong" when the rules has a split action". The
problem a user observed, and its root cause:

### Verified issue does not already exist?

- [x] I have searched and found no existing issue

### What happened?

In the budget, clicking to run rules results in an error if the rule includes an action to create a split transaction. However, for other rules, it functions properly. 

Running the same rule from the rule editor view, on the other hand, works correctly even for the split transaction.


### How can we reproduce the issue?

How to replicate:
- Create a rule like this:
![Image](https://github.com/user-attachments/assets/256abdb8-2362-40f4-8826-c35a90dc8d12)
- go to all account
- search the transaction that the rules can be excuted (in this case, the one of Dominion Power)
- select one
- from the drop-down menu of the transaction click Run Rules.

You will see this appearing 

![Image](https://github.com/user-attachments/assets/8eade8a8-ef80-4504-bb32-ed3b8e5b8327)

but there's no log or anything in the terminal.


NOTE: if you run the rule from the rule edit view, it works properly
NOTE2: even if i built this functionality, i'm not so expert to fix this problem, nor i understand why it happens. 

### Where are you hosting Actual?

Pikapods

### What browsers are you seeing the problem on?

Chrome

### Operating System

Mac OSX

This same root cause must be fixed before merging.
REVIEW_EOF
