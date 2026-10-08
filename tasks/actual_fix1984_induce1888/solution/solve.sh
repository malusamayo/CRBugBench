#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/loot-core/src/server/budget/goals/goalsSchedule.ts`:

This pull request introduces the defect later reported as "[Bug]: Wrong amount budgeted for category with multiple schedule goal templates". The
problem a user observed, and its root cause:

### Verified issue does not already exist?

- [X] I have searched and found no existing issue

### What happened?

I create 3 monthly schedules which total 327.11.
![image](https://github.com/actualbudget/actual/assets/2781017/f815c2ff-8d76-42f5-ad5d-8903ffaeb3c9)

Then I add them as goal templates to the category "Bills":

```
#template schedule Rent
#template schedule Electricity
#template schedule Mobile
```

Finally I apply the budget template for December and expect that 327.11 is budgeted. However triple that (981.33) is budgeted.

![image](https://github.com/actualbudget/actual/assets/2781017/b63ccac5-6dd9-4f9f-adf2-318eb63db20a)

It appears that if X schedule goal templates are added to a category the budgeted amount for each schedule is added X times to the category.

Sample database to reproduce the bug: [schedules-goals.zip](https://github.com/actualbudget/actual/files/13480319/schedules-goals.zip)

cc @shall0pass you've done a lot of work in this area





### What error did you receive?

_No response_

### Where are you hosting Actual?

Docker

### What browsers are you seeing the problem on?

Firefox

### Operating System

None

This same root cause must be fixed before merging.
REVIEW_EOF
