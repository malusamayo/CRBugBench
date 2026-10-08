#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `web/src/components/Calendar.jsx`:

This pull request introduces the defect later reported as "[Support]: Date picker in events page can show wrong month". The
problem a user observed, and its root cause:

### Describe the problem you are having

The date picker on the events page, after you select the first (start) date, the calendar inside of the event picker reverts to the current month, but the month label and arrows do not revert to the current month. I would say the calendar should not revert to the current month either.

For example, try to select dates June 10-12th. If you select the 12th, the calendar will appear to still be in June, but when you select the 12th, it'd select June 10th to July 12th. To select June 12, you need to hit the month change arrow once in each direction to get back to displaying June correctly.

### Version

0.13.0-598AE98

### Frigate config file

```yaml
NA
```


### Relevant log output

```shell
NA
```


### FFprobe output from your camera

```shell
NA
```


### Frigate stats

_No response_

### Operating system

Debian

### Install method

Docker CLI

### Coral version

USB

### Network connection

Wired

### Camera make and model

NA

### Any other information that may be helpful

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
