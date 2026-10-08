#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `homeassistant/components/workday/calendar.py`:

This pull request introduces the defect later reported as "Workday Calendar entity state does not reflect binary sensor". The
problem a user observed, and its root cause:

### The problem

The new workday calendar entity does not update its state.
The all day calendar entries appear but the state remains off when should be on, the binary sensor is correct.
Other calendars update their state to on when an all day event is active.

<img width="676" height="241" alt="Image" src="https://github.com/user-attachments/assets/6f46eee5-dee6-44f1-8f10-47df1a8963a5" />

### What version of Home Assistant Core has the issue?

2025.10.0

### What was the last working version of Home Assistant Core?

None

### What type of installation are you running?

Home Assistant Container

### Integration causing the issue

Workday

### Link to integration documentation on our website

https://www.home-assistant.io/integrations/workday/

### Diagnostics information

[config_entry-workday-01K6J91P9J31W1XW56EZ2FR0JG.json](https://github.com/user-attachments/files/22658304/config_entry-workday-01K6J91P9J31W1XW56EZ2FR0JG.json)

### Example YAML snippet

```yaml

```

### Anything in the logs that might be useful for us?

```txt

```

### Additional information

I removed my existing entry and re-created to see if that fixed it but still the same.

This same root cause must be fixed before merging.
REVIEW_EOF
