#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `web/src/components/RelativeModal.jsx`:

This pull request introduces the defect later reported as "Blink on rollover of toggle buttons in the web interface". The
problem a user observed, and its root cause:

**Describe the bug**
When rolling over any of the toggle buttons for each camera in the web interface, the camera grid blinks and blanks out. Also mentioned here: https://community.home-assistant.io/t/local-realtime-person-detection-for-rtsp-cameras/103107/3702

Black images at bottom are actually disabled and expected.

**Version of frigate**
Frigate version 0.8.3, HA add-on version 1.11

**Config file**
```
detectors:
  coral:
    type: edgetpu
    device: 'usb:0'
mqtt:
  host: 192.168.2.6
  topic_prefix: frigate
  user: mqtt
  password:
ffmpeg: {}
cameras:
  deck:
    ffmpeg:
      inputs:
        - path: 'URL'
          roles:
            - detect
            - rtmp
            - clips
    height: 576
    width: 1024
    fps: 5
    motion:
      mask: >-
        269,275,262,93,196,85,219,2,431,3,589,1,1022,1,1021,573,806,574,868,183,510,128,489,121,279,122,289,271
    clips:
      enabled: true
      pre_capture: 30
    record:
      enabled: false
      retain_days: 30
  front_door:
    ffmpeg:
      inputs:
        - path: 'URL'
          roles:
            - detect
            - rtmp
            - clips
    height: 576
    width: 1024
    fps: 5
    motion:
      mask: '184,161,174,1,723,1,719,141,422,157'
    clips:
      enabled: true
      pre_capture: 30
    record:
      enabled: false
      retain_days: 30
  hallway:
    ffmpeg:
      inputs:
        - path: 'URL'
          roles:
            - detect
            - rtmp
            - clips
    height: 576
    width: 1024
    fps: 5
    clips:
      enabled: true
      pre_capture: 30
    record:
      enabled: false
      retain_days: 30
  front_door_indoor:
    ffmpeg:
      inputs:
        - path: 'URL'
          roles:
            - detect
            - rtmp
            - clips
    height: 576
    width: 1024
    fps: 5
    clips:
      enabled: true
      pre_capture: 30
    record:
      enabled: false
      retain_days: 30
clips:
  max_seconds: 300
  retain:
    default: 10
    objects:
      person: 15
objects:
  track:
    - person
  filters:
    person:
      min_area: 7000
      max_area: 100000
      min_score: 0.4
      threshold: 0.7
```


**Screenshots**
![Frigate Rollover](https://user-images.githubusercontent.com/210236/108854043-68a36080-75b5-11eb-9160-d4220dd0e88c.gif)

**Computer Hardware**
 - OS: mac OS 11.2.1
 - Browsers: Safari 14.0.3, Chrome 88, Firefox 85.02. All had the same problem
 - Install method: HA Addon
 - Virtualization: N/A
 - Coral Version: USB
 - Network Setup: Wired

This same root cause must be fixed before merging.
REVIEW_EOF
