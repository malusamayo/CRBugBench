#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `netbox/ipam/migrations/0029_3569_ipaddress_fields.py`:

This pull request introduces the defect later reported as "IPAddress DHCP status is not migrated". The
problem a user observed, and its root cause:

<!--
    NOTE: This form is only for reproducible bugs. If you need assistance with
    NetBox installation, or if you have a general question, DO NOT open an
    issue. Instead, post to our mailing list:

        https://groups.google.com/forum/#!forum/netbox-discuss

    Please describe the environment in which you are running NetBox. Be sure
    that you are running an unmodified instance of the latest stable release
    before submitting a bug report.
-->
### Environment
* Python version:  3.7<!-- Example: 3.5.4 -->
* NetBox version:  2.7.2<!-- Example: 2.5.2 -->

<!--
    Describe in detail the exact steps that someone else can take to reproduce
    this bug using the current stable release of NetBox (or the current beta
    release where applicable). Begin with the creation of any necessary
    database objects and call out every operation being performed explicitly.
    If reporting a bug in the REST API, be sure to reconstruct the raw HTTP
    request(s) being made: Don't rely on a wrapper like pynetbox.
-->
### Steps to Reproduce
1. Upgrade from v2.6.3
2. Execute migration
2. Show IPAddress whose status is "DHCP"

<!-- What did you expect to happen? -->
### Expected Behavior
Show the IP correctly

<!-- What happened instead? -->
### Observed Behavior
* The status column/row shows nothing (actually, shows string "5" as Invisible Man)
* IPAddress resource API returns an error: `Key Not Found: '5'`

This same root cause must be fixed before merging.
REVIEW_EOF
