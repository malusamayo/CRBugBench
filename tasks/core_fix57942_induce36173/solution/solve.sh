#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `homeassistant/components/tile/__init__.py`:

This pull request introduces the defect later reported as "All Tile entities become unavailable when second tile account is being added". The
problem a user observed, and its root cause:

### The problem

Using the Tile integration with only one tile account does work and current data will be polled from tile cloud service.
As soon as a second Tile account is added via Integrations, all tile entities (from first account and second account) become unavailable. 
After removing one of the accounts, the entities of the other one will be available again.

logs say, credentials are invalid, which is not the case, since they work if only one account is being connected.

Best

### What is version of Home Assistant Core has the issue?

core-2021.10.5

### What was the last working version of Home Assistant Core?

_No response_

### What type of installation are you running?

Home Assistant Supervised

### Integration causing the issue

tile

### Link to integration documentation on our website

https://www.home-assistant.io/integrations/tile/

### Example YAML snippet

_No response_

### Anything in the logs that might be useful for us?

Error fetching Wallet 01 Tile data: Error while retrieving data: Invalid credentials
Error fetching Keyring 01 Tile data: Error while retrieving data: Invalid credentials
Error fetching Carkey 01 Tile data: Error while retrieving data: Invalid credentials

### Additional information

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
