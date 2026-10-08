#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `ts/routes/graphs/reviews.ts`:

This pull request introduces the defect later reported as "Overlapping ranges in Reviews graph when All history is selected". The
problem a user observed, and its root cause:

When All history is selected, the Reviews graph shows bars with overlapping ranges.

The first bar from right shows "0-19 days"
<img width=300 src="https://github.com/user-attachments/assets/ab75b502-14f8-44db-afb9-2594229e4be2">

The second bar from right shows "1-20 days ago"
<img width=300 src="https://github.com/user-attachments/assets/bf9bd954-bdd0-4d68-8e45-e612ed6de7fa">

This same root cause must be fixed before merging.
REVIEW_EOF
