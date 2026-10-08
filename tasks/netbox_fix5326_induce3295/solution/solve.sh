#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `netbox/extras/templatetags/custom_links.py`:

This pull request introduces the defect later reported as "Missing "\n" in code for custom link group menus leads to inconsitent UI formating". The
problem a user observed, and its root cause:

<!--
    NOTE: IF YOUR ISSUE DOES NOT FOLLOW THIS TEMPLATE, IT WILL BE CLOSED.

    This form is only for reproducible bugs. If you need assistance with
    NetBox installation, or if you have a general question, DO NOT open an
    issue. Instead, post to our mailing list:

        https://groups.google.com/g/netbox-discuss

    Please describe the environment in which you are running NetBox. Be sure
    that you are running an unmodified instance of the latest stable release
    before submitting a bug report, and that any plugins have been disabled.
-->
### Environment
* Python version: 3.6.8
* NetBox version: 2.9.7
* Browser: Firefox 82.0

<!--
    Describe in detail the exact steps that someone else can take to reproduce
    this bug using the current stable release of NetBox. Begin with the
    creation of any necessary database objects and call out every operation
    being performed explicitly. If reporting a bug in the REST API, be sure to
    reconstruct the raw HTTP request(s) being made: Don't rely on a client
    library such as pynetbox.
-->
### Steps to Reproduce
1.add a custom link without a group and then add links so that 2 grouped links are next to each other.
2. Open the UI and look at an object that has those links

<!-- What did you expect to happen? -->
### Expected Behavior
Equal amount of whitespace between all buttons

<!-- What happened instead? -->
### Observed Behavior
No whitespace between the dropdown buttons

![Screenshot_2020-11-09 stu-i28-lab-cs - NetBox(2)](https://user-images.githubusercontent.com/1368323/98508495-dbcfd380-225f-11eb-903f-86c48b4d85ab.png)

### How to fix it:
Add a \n at the end of the line in 
https://github.com/netbox-community/netbox/blob/f53810ebb29f0ef26c53b5be1973263e89b01f54/netbox/extras/templatetags/custom_links.py#L19
![netbox-ui-fixed](https://user-images.githubusercontent.com/1368323/98508520-e4c0a500-225f-11eb-995e-44396def4045.png)

This same root cause must be fixed before merging.
REVIEW_EOF
