#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `netbox/ipam/tables.py`:

This pull request introduces the defect later reported as "Prefixes per VLAN no longer listed in VLANs list after upgrade to 2.9.2". The
problem a user observed, and its root cause:

<!--
    NOTE: IF YOUR ISSUE DOES NOT FOLLOW THIS TEMPLATE, IT WILL BE CLOSED.

    This form is only for reproducible bugs. If you need assistance with
    NetBox installation, or if you have a general question, DO NOT open an
    issue. Instead, post to our mailing list:

        https://groups.google.com/forum/#!forum/netbox-discuss

    Please describe the environment in which you are running NetBox. Be sure
    that you are running an unmodified instance of the latest stable release
    before submitting a bug report, and that any plugins have been disabled.
-->
### Environment
* Python version: 3.8.2
* NetBox version: 2.8.6 / 2.9.2

<!--
    Describe in detail the exact steps that someone else can take to reproduce
    this bug using the current stable release of NetBox. Begin with the
    creation of any necessary database objects and call out every operation
    being performed explicitly. If reporting a bug in the REST API, be sure to
    reconstruct the raw HTTP request(s) being made: Don't rely on a client
    library such as pynetbox.
-->
### Steps to Reproduce
1. [Netbox 2.8.6] Create VLAN Group with name "test"
2. [Netbox 2.8.6] Create VLAN with ID 1, name "test", group "test"
3. [Netbox 2.8.6] Create Prefix 10.0.0.0/24 with VLAN group "test" and vlan "test (1)".
4. [Netbox 2.8.6] Go to IPAM -> VLAN Groups -> test
5. [Netbox 2.8.6] Observe and take note of the "Prefixes" column for VLAN "test".
6. Upgrade Netbox from 2.8.6 to 2.9.2
7. [Netbox 2.9.2] Go to IPAM -> VLAN Groups -> test
8. [Netbox 2.9.2] Again, observe and take note of the "Prefixes" column for VLAN "test".


<!-- What did you expect to happen? -->
### Expected Behavior
Prefixes per VLAN are still listed in the "Prefixes" column after upgrade to Netbox 2.9.2.

<!-- What happened instead? -->
### Observed Behavior
Prefixes per VLAN are no longer listed in the "Prefixes" column after upgrade to Netbox 2.9.2.

This same root cause must be fixed before merging.
REVIEW_EOF
