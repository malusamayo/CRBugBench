#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/main/java/org/jabref/gui/JabRefFrame.java`:

This pull request introduces the defect later reported as "Multiple background task popups stacked over each other". The
problem a user observed, and its root cause:

JabRef version 100,0,0 (12.5.2020 22:00 pm) on Windows 10 10.0 amd64 Java14

- [x] I have tested the latest development version from http://builds.jabref.org/master/ and the problem persists

Steps to reproduce the behavior:
1. Click on the background tasks button in the tollbar.
2. Click on it again
3. And again

You can see that the shadow of the popup is getting darker each time.

![grafik](https://user-images.githubusercontent.com/50491877/81740954-110c8c00-949e-11ea-9948-7b84c1862aa7.png)

![grafik](https://user-images.githubusercontent.com/50491877/81740897-fafecb80-949d-11ea-9b91-912e51d3e1bc.png)

This same root cause must be fixed before merging.
REVIEW_EOF
