#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `desktop/src/main/java/bisq/desktop/main/MainView.java`:

This pull request introduces the defect later reported as "Available balance pop-up currency wrong". The
problem a user observed, and its root cause:

### Description

At the top right corner of the window, we have the drop down menu for BTC rates, the available balance, the reserved funds and locked funds (all these last 3 in BTC units).
When the mouse is over any of these last three, the software calculates the value in the respective rate and displays a pop-up with the value converted to whatever currency was selected in the drop down menu.
Even though the conversion is working alright, the symbol that is always shown is "USD".
For example, check below what happens when BTC/COP is selected (Colombian Peso):

![image](https://user-images.githubusercontent.com/6444444/67819947-09ebd680-fa96-11e9-90c7-5979e4636b8a.png)

I wish I had 702k USD!!! :-)

#### Version

v1.2.0

### Steps to reproduce

Change the rate at the drop down and observe.


### Expected behaviour

In the example above, the pop-up should show 702.324,79 COP.

### Actual behaviour

Instead of showing "COP", it showed "USD" (it shows "USD" always)

This same root cause must be fixed before merging.
REVIEW_EOF
