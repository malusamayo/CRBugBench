#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `netbox/templates/vpn/l2vpntermination_edit.html`:

This pull request introduces the defect later reported as "L2VPN Termination tabs inconsistency in edit mode". The
problem a user observed, and its root cause:

### Deployment Type

Self-hosted

### NetBox Version

v3.7.2

### Python Version

3.8

### Steps to Reproduce

1. Create an L2VPN, and a Virtual Machine interface
2. Create an L2VPN Termination - choose the 'Virtual Machine' tab and select the interface and save.
3. Edit the L2VPN Termination

Notice both the VLAN and 'Virtual Machine' tabs are highlighted, and there is are both the VLAN and Interface selections showing below.

![Monosnap Editing L2VPN termination eth0   TEST | NetBox 2024-02-08 09-25-25](https://github.com/netbox-community/netbox/assets/99642/c08ab5d6-4612-4af1-becc-888d2a9cdb85)


### Expected Behavior

Only one tab should be highlighted and only the correct field for the tab should be shown, not the fields for both tabs.

### Observed Behavior

Both tabs are highlighted and fields for both tabs are shown.

This same root cause must be fixed before merging.
REVIEW_EOF
