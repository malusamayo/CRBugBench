#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `frigate/util.py`:

This pull request introduces the defect later reported as "[Support]: RTSP password not correctly masked / in log file". The
problem a user observed, and its root cause:

### Describe the problem you are having

Password is shown in Log FIle

```
Ffmpeg process crashed unexpectedly for E1ProBabyRoom.
The following ffmpeg logs include the last 100 lines prior to exit.
rtsp://*:*@192.168.1.3:554/h264Preview_01_sub: Protocol not found
Did you mean file:rtsp://hass:Welcome123%21@192.168.1.3:554
```

### Version

0.12.0-e454daf

### Frigate config file

```yaml
Not relevant
```


### Relevant log output

```shell
2023-03-21 20:01:53.982583022  [2023-03-21 20:01:53] watchdog.E1ProBabyRoom         ERROR   : Ffmpeg process crashed unexpectedly for E1ProBabyRoom.
2023-03-21 20:01:53.982672799  [2023-03-21 20:01:53] watchdog.E1ProBabyRoom         ERROR   : The following ffmpeg logs include the last 100 lines prior to exit.
2023-03-21 20:01:53.982710434  [2023-03-21 20:01:53] ffmpeg.E1ProBabyRoom.detect    ERROR   : rtsp://*:*@192.168.1.3:554/h264Preview_01_sub: Protocol not found
2023-03-21 20:01:53.982783621  [2023-03-21 20:01:53] ffmpeg.E1ProBabyRoom.detect    ERROR   : Did you mean file:rtsp://hass:Welcome123%21@192.168.1.3:554
```

### Operating system

Other Linux

### Install method

Kubernetes

### Coral version

CPU (no coral)

### Network connection

Wireless

### Camera make and model

Reolink E1 Pro

### Any other information that may be helpful

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
