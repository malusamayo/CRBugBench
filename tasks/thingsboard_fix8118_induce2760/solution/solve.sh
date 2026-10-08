#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `ui-ngx/src/app/modules/home/components/widget/lib/digital-gauge.ts`:

This pull request introduces the defect later reported as "[Bug] Horizontal bar displays incorrectly decimal numeric values that ends with zeros - 42.0, 50.0 etc.". The
problem a user observed, and its root cause:

**Describe the bug**
A clear and concise description of what the bug is.
![image](https://user-images.githubusercontent.com/3466101/220391785-29b25b52-eb62-4a31-bf93-b62c8aea9823.png)

Bar doesn't properly fills bar with green color. 
In the sample above: min value - 0, max value - 100, current value - 42.0 - but the green fill is not filled 42% of the bar.
Current value on device:
![image](https://user-images.githubusercontent.com/3466101/220392293-f8dba669-779b-43c7-a134-93d1e57acdcf.png)

If temp value equals 42 or 42.1 - everything works as expected:
![image](https://user-images.githubusercontent.com/3466101/220392463-2c9fabbc-804a-4ffa-a9e4-bafb98032091.png)
![image](https://user-images.githubusercontent.com/3466101/220392530-40b2ff79-8296-40ab-ba89-a050b5cc9dc7.png)

**Workaround**: disable animation in the widget settings:
![image](https://user-images.githubusercontent.com/3466101/220392738-75b2f61d-eecb-4999-b03f-c5cb4eb186ca.png)


**Your Server Environment**
<!-- 🔅🔅🔅🔅🔅🔅🔅 Choose one of the following or write your own 🔅🔅🔅🔅🔅🔅🔅-->
* demo.thingsboard.io
* cloud.thingsboard.io
* own setup
  * cloud or local infrastructure or docker deployment
  * ThingsBoard Version
  * OS Name and Version

**Your Client Environment**
<!-- 🔅🔅🔅🔅🔅🔅🔅 Choose one of the following or write your own 🔅🔅🔅🔅🔅🔅🔅-->
**Desktop (please complete the following information):**

* OS: [e.g. iOS]
* Browser [e.g. chrome, safari]
* Version [e.g. 22]

**Smartphone (please complete the following information):**
* Device: [e.g. iPhone6]
* OS: [e.g. iOS8.1]
* Browser [e.g. stock browser, safari]
* Version [e.g. 22]

**Your Device**

* Connectivity
  * MQTT
  * HTTP
  * CoAP
  * Gateway
  * Integration: (Specify name) 
* Device vendor and model

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

**Expected behavior**
A clear and concise description of what you expected to happen.

**Screenshots**
If applicable, add screenshots to help explain your problem.

**Additional context**
Add any other context about the problem here.

This same root cause must be fixed before merging.
REVIEW_EOF
