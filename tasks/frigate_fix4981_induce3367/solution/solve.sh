#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `frigate/http.py`:

This pull request introduces the defect later reported as "[Support]: Zone 'None' empty". The
problem a user observed, and its root cause:

### Describe the problem you are having

If I select to display zone 'None' only then I get an empty list.

![img](https://user-images.githubusercontent.com/117124485/211290724-8c282cea-edd5-41c7-a9e8-66bb37a3a6e6.png)


### Version

0.12.0-0DBF909

### Frigate config file

```yaml
-
```


### Relevant log output

```shell
-
```


### FFprobe output from your camera

```shell
-
```


### Frigate stats

_No response_

### Operating system

Proxmox

### Install method

Docker Compose

### Coral version

USB

### Network connection

Wired

### Camera make and model

_No response_

### Any other information that may be helpful

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
