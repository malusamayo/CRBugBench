#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `public/app/features/dashboard/state/PanelModel.ts`:

This pull request introduces the defect later reported as "Bar Guage - thresholds keep resetting.". The
problem a user observed, and its root cause:

Hi,

I love the new Bar Guage option. I run it with All Values, Retro LCD and remove one of the default threshold options leaving in only Base in Green. I save the dashboard then exit out of it and load it back up, an additional threshold then appears with default value of 80 in Red.

![image](https://user-images.githubusercontent.com/30800227/67555668-a7977c80-f709-11e9-840e-0731b1f6ade4.png)

Grafana v6.2.5 (6082d19)

This same root cause must be fixed before merging.
REVIEW_EOF
