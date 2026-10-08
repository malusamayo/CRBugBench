#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `docker/main/rootfs/usr/local/go2rtc/create_config.py`:

This pull request introduces the defect later reported as "WebRTC through WAN while client is on the same LAN". The
problem a user observed, and its root cause:

Environment: HomeAssistant on RPI4 64 bit, HASSIO addon Frigate (Full Access) 0.12.1

Since some version of go2rtc, when client is on same LAN as HA, in some cases WebRTC candidate is chosen of type **srflx** which causes traffic to go through WAN interface back and forth. This really bad for my 4G connection with limited traffic.

go2rtc versions checked: 1.2.0, 1.6.2, 1.7.1

v1.2.0 (bundled with addon) works correctly, i.e. while client on same LAN as HA, the **host** candidate is always chosen, both for Chrome on wired desktop and for HA Companion app on Android phone (WiFi)

v1.6.2 and 1.7.1 (placed one by one to config directory) - issue is the same for both. For wired desktop with Chrome, **srflx** candidate is chosen, and all traffic goes through WAN interface. Surprisingly, HA Companion App still works throug LAN.

My config:

```
mqtt:
  host: homeassistant.local
  user: ***
  password: ***

ffmpeg:
  hwaccel_args: preset-rpi-64-h264

detectors:
  cpu1:
    type: cpu
    num_threads: 3

objects:
  track:
    - person
    - car
    - cat
    - dog

record:
  enabled: true
  retain:
    days: 14
    mode: motion

snapshots:
  enabled: true

go2rtc:
  streams:
    rtsp_outdoor_hq:
      - rtsp://***:***@192.168.2.201:554/cam/realmonitor?channel=1&subtype=0
    rtsp_outdoor_lq:
      - rtsp://***:***@192.168.2.201:554/cam/realmonitor?channel=1&subtype=1

cameras:
  outdoor:
    ffmpeg:
      inputs:
        - path: rtsp://localhost:8554/rtsp_outdoor_hq
          input_args: preset-rtsp-restream
          roles:
            - record
        - path: rtsp://localhost:8554/rtsp_outdoor_lq
          input_args: preset-rtsp-restream
          roles:
            - detect
    live:
      stream_name: rtsp_outdoor_lq
    detect:
      width: 640
      height: 480
    motion:
      mask:
        - 640,0,640,225,252,0
    zones:
      driveway:
        coordinates: 150,480,640,480,640,327,398,125,44,224
      gate:
        coordinates: 248,480,109,480,29,241,78,230
```

This same root cause must be fixed before merging.
REVIEW_EOF
