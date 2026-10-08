#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `homeassistant/components/recorder/run_history.py`:

This pull request introduces the defect later reported as "Recorder fails to get run history while db migration in progress". The
problem a user observed, and its root cause:

### The problem

As long as the DB migration from 30 to 33 was running, only "error unknown" was displayed under System -> Repairs -> Overflow Menu -> System Information in the "Recorder" section. After the migration was completed, the correct data was displayed (database version, size, etc).

### What version of Home Assistant Core has the issue?

core-2023.2.0

### What was the last working version of Home Assistant Core?

_No response_

### What type of installation are you running?

Home Assistant OS

### Integration causing the issue

Recorder

### Link to integration documentation on our website

https://www.home-assistant.io/integrations/recorder/

### Diagnostics information

_No response_

### Example YAML snippet

```yaml
recorder:
  db_url: !secret recorder_db_url
  purge_keep_days: 30
  exclude:
    entities:
      - sensor.switch_uptime
      - sensor.master_uptime
      - sensor.backup_uptime
```


### Anything in the logs that might be useful for us?

```txt
Recorder
error          unknown

Logger: homeassistant.components.system_health
Source: components/recorder/run_history.py:67
Integration: Systemzustand (documentation, issues)
First occurred: 21:43:53 (2 occurrences)
Last logged: 21:47:27

Error fetching info
Traceback (most recent call last):
  File "/usr/src/homeassistant/homeassistant/components/system_health/__init__.py", line 71, in get_integration_info
    data = await registration.info_callback(hass)
  File "/usr/src/homeassistant/homeassistant/components/recorder/system_health/__init__.py", line 71, in system_health_info
    "oldest_recorder_run": run_history.first.start,
  File "/usr/src/homeassistant/homeassistant/components/recorder/run_history.py", line 62, in first
    return self.current
  File "/usr/src/homeassistant/homeassistant/components/recorder/run_history.py", line 67, in current
    assert self._current_run_info is not None
AssertionError
```


### Additional information

<details><summary>Recorder</summary>

oldest_recorder_run | 4. Januar 2023 um 21:06
-- | --
current_recorder_run | 1. Februar 2023 um 21:17
estimated_db_size | 1055.47 MiB
database_engine | mysql
database_version | 10.3.32

</details>

This same root cause must be fixed before merging.
REVIEW_EOF
