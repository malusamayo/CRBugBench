#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `ui-ngx/src/app/shared/models/device.models.ts`:

This pull request introduces the defect later reported as "[Bug] Fail to use "MD5" as Authentication Protocol in SNMP v3 Device Registration". The
problem a user observed, and its root cause:

When a new device with a device profile having transport type equal to SNMP is registered with Transport Configuration Authentication Protocol set to MD5, the registration process is rejected with a RED error bar attached.

**Your Server Environment**
<!-- 🔅🔅🔅🔅🔅🔅🔅 Choose one of the following or write your own 🔅🔅🔅🔅🔅🔅🔅-->
* own setup
  * ThingsBoard PE v3.3.2
  * CentOS 7.8 (64-bit)

**Your Client Environment**
<!-- 🔅🔅🔅🔅🔅🔅🔅 Choose one of the following or write your own 🔅🔅🔅🔅🔅🔅🔅-->
**Desktop (please complete the following information):**

* OS: Windows 10
* Firefox
* Version 98.0.2

**Your Device**

* Connectivity
  * SNMPv3

**Screenshots**
![image](https://user-images.githubusercontent.com/15992647/161780926-a486376a-7998-4cf6-8779-309b04187f79.png)

This same root cause must be fixed before merging.
REVIEW_EOF
