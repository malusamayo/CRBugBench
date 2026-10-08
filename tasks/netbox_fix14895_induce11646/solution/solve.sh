#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `netbox/core/api/serializers.py`:

This pull request introduces the defect later reported as "Data Source custom fields are not available through REST API". The
problem a user observed, and its root cause:

### Deployment Type

Self-hosted

### NetBox Version

v3.7.1

### Python Version

3.10

### Steps to Reproduce

1. Create custom field and assign it to Data Source.
2. Create Data Source and fill out respective custom field via GUI.
3. Try to get the information about created Data Source through REST API - there will be no "custom_fields" field.
4. If you try to create Data Source through REST API "custom_fields" field will be ignored.

### Expected Behavior

There should be consistency in interaction with Data Sources (or any other model). If a user can assign custom fields to this model through web GUI, then the same opportunity should also exist for REST API.

All that's required to do for this issue is just add "custom_fields" here
https://github.com/netbox-community/netbox/blob/develop/netbox/core/api/serializers.py#L37

### Observed Behavior

Neither reading nor changing "custom_fields" value for a Data Source is available through REST API.

This same root cause must be fixed before merging.
REVIEW_EOF
