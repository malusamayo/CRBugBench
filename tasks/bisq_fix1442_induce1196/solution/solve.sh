#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `gui/src/main/java/io/bisq/gui/components/AddressWithIconAndDirection.java`:

This pull request introduces the defect later reported as "Layout of transaction list items is not vertically centered". The
problem a user observed, and its root cause:

Layout of transaction list items is not vertically centered in row ("Sent to:, Received with:"). 

<img width="1200" alt="screen shot 2018-03-08 at 20 19 40" src="https://user-images.githubusercontent.com/1449498/37185390-1807c708-230e-11e8-8ad1-33119cb2a057.png">

This same root cause must be fixed before merging.
REVIEW_EOF
