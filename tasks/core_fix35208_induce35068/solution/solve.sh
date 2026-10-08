#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `homeassistant/components/synology_dsm/sensor.py`:

This pull request introduces the defect later reported as "Some Synology sensors have gone in 0.109.3". The
problem a user observed, and its root cause:

<!-- READ THIS FIRST:
  - If you need additional help with this template, please refer to https://www.home-assistant.io/help/reporting_issues/
  - Make sure you are running the latest version of Home Assistant before reporting an issue: https://github.com/home-assistant/core/releases
  - Do not report issues for integrations if you are using custom components or integrations.
  - Provide as many details as possible. Paste logs, configuration samples and code into the backticks.
  DO NOT DELETE ANY TEXT from this template! Otherwise, your issue may be closed without comment.
-->
## The problem
<!-- 
  Describe the issue you are experiencing here to communicate to the
  maintainers. Tell us what you were trying to do and what happened.
-->
I have updated my HA from 0.109.2 to 0.109.3 and lost some Synology integration sensors. I still see them on the 'Synology NAS (sda)' device page of the integration, but they have 'unknown status'.
These sensors have gone:
- sensor.synology_below_min_remaining_life_sda (last letter corresponds to disk)
- sensor.synology_exceeded_max_bad_sectors_sda (last letter corresponds to disk)

## Environment
<!--
  Provide details about the versions you are using, which helps us to reproduce
  and find the issue quicker. Version information is found in the
  Home Assistant frontend: Developer tools -> Info.
-->

- Home Assistant Core release with the issue: 0.109.3
- Last working Home Assistant Core release (if known): 0.109.2 
- Operating environment (Home Assistant/Supervised/Docker/venv): Home Assistant (ex HASSio)/Docker/Synology DSM
- Integration causing this issue: Synology DSM 
- Link to integration documentation on our website: [https://www.home-assistant.io/integrations/synology_dsm/](https://www.home-assistant.io/integrations/synology_dsm/)

## Problem-relevant `configuration.yaml`
<!--
  An example configuration that caused the problem for you. Fill this out even
  if it seems unimportant to you. Please be sure to remove personal information
  like passwords, private URLs and other credentials.
-->

```
Since 0.109 the platform has no YAML mode.
```

## Traceback/Error logs
<!--
  If you come across any trace or error logs, please provide them.
-->

```
None.
```

## Additional information
![Screenshot 2020-05-04 at 13 41 20](https://user-images.githubusercontent.com/47206760/80958013-f6d30e00-8e0c-11ea-9aea-82e48bdb7a5a.png)

This same root cause must be fixed before merging.
REVIEW_EOF
