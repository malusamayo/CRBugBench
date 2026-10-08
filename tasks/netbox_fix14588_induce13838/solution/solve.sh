#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `netbox/ipam/forms/model_forms.py`:

This pull request introduces the defect later reported as "VLAN filtering with VLAN groups". The
problem a user observed, and its root cause:

### NetBox version

v3.6.2

### Python version

3.8

### Steps to Reproduce

I have vlans associated to a vlan group. This vlan group scope is a site group. Sites A and B are member of this site group
When I create a new prefix associated to site A, I expect vlans from the vlan group to appear. They don't

On demo website : 
- Create a vlan group "Test-Group", scope type DCIM > site group. Choose a site group, Headquarters for instance
![image](https://github.com/netbox-community/netbox/assets/64533932/02626fe0-d508-4d27-84c3-748ed8614380)

- Create a vlan and associate it with this vlan group
![image](https://github.com/netbox-community/netbox/assets/64533932/d778065e-7ecc-48ee-85de-5c5b8839d54b)

- Associate a site to the Headquarters site group, or select one already in it
![image](https://github.com/netbox-community/netbox/assets/64533932/7fd5ef34-5453-4c08-8f4d-c2cdab3a9d0d)

- Try to create a prefix with this site. You won't see the vlan
![image](https://github.com/netbox-community/netbox/assets/64533932/e763fc0f-4d14-45a6-9cd6-6db61863560a)




### Expected Behavior

When you define a vlan group with site group as a scope, you expect its site members  to "inherit" the vlan. I think this part is ok, but you can't select the vlan in prefix creation

### Observed Behavior

The vlan is not visible in prefix creation, maybe due to #13721

As a side note, the vlan appears in 802.1q swiching in interfaces for a device member of the site DM-NYC
![image](https://github.com/netbox-community/netbox/assets/64533932/470eb588-7d6c-410d-a26e-bfac02d52223)

This same root cause must be fixed before merging.
REVIEW_EOF
