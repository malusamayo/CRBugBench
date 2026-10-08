#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `frigate/events/audio.py`:

This pull request introduces the defect later reported as "[Config Support]: Audio event ffmpeg fails if input_args is not a preset". The
problem a user observed, and its root cause:

### Describe the problem you are having

I'm using custom ffmpeg arguments and experimenting with audio event detection.  At some point between beta2 and beta6, audio detection stopped working and an exception is logged when events/audio.py tries to concatenate global_args and input_args.  I think maybe input_args also needs to be run through get_ffmpeg_arg_list?

### Version

0.13.0-614a36a

### Frigate config file

```yaml
mqtt:
  host: portal.home
  user: frigate
  password: "{FRIGATE_MQTT_PASSWORD}"
  stats_interval: 30

detectors:
  #cpu_warmer:
  #  type: cpu
  #  num_threads: 4
  coral_edgetpu_pcie:
    type: edgetpu
    device: pci:0

snapshots:
  enabled: True
  bounding_box: True
  quality: 95
  #height: 480

audio:
  enabled: True
  min_volume: 350
  listen:
    - bark
    - fire_alarm
    - speech

record:
  enabled: True
  retain:
    days: 14
    mode: all
  events:
    #max_seconds: 300
    pre_capture: 5
    post_capture: 10

birdseye:
  # continuous, objects, motion
  mode: continuous
  #mode: objects
  #mode: motion
  quality: 1
  width: 1920
  height: 1080
  restream: True

live:
  #height: 1080
  height: 720
  #height: 540
  quality: 1

detect:
  enabled: True
  #width: 1920
  #height: 1080
  width: 1280
  height: 720
  # Default is 5 fps.  The detector feeds the live and birdseye views
  # as well, so those can not have a higher resolution nor higher
  # framerate than the detector is receiving from output_args.detect.
  fps: 10
  # Number of frames before an object is considered gone, default 5s.
  max_disappeared: 50  # 5 seconds
  stationary:
    # Confirm the presence of an object after this many frames by
    # re-running object detection.  Default is 0, which confirms
    # object only when motion is detected.
    interval: 300  # 30 seconds
    # Number of frames without a position change to consider an object
    # stationary, default 10s.
    threshold: 100  # 10 seconds

rtmp:
  enabled: False

timestamp_style:
  position: "tl"
  format: "%Y-%m-%d %H:%M:%S"
  # color:
  #   red: 255
  #   green: 255
  #   blue: 255
  thickness: 1
  effect: shadow

# Optional: Motion configuration
# NOTE: Can be overridden at the camera level
motion:
  # Optional: The threshold passed to cv2.threshold to determine if a pixel is different enough to be counted as motion. (default: shown below)
  # Increasing this value will make motion detection less sensitive and decreasing it will make motion detection more sensitive.
  # The value should be between 1 and 255.
  #threshold: 25
  # Optional: Minimum size in pixels in the resized motion image that counts as motion (default: 30)
  # Increasing this value will prevent smaller areas of motion from being detected. Decreasing will
  # make motion detection more sensitive to smaller moving objects.
  # As a rule of thumb:
  #  - 15 - high sensitivity
  #  - 30 - medium sensitivity
  #  - 50 - low sensitivity
  #contour_area: 30
  # Optional: Alpha value passed to cv2.accumulateWeighted when averaging the motion delta across multiple frames (default: shown below)
  # Higher values mean the current frame impacts the delta a lot, and a single raindrop may register as motion.
  # Too low and a fast moving person wont be detected as motion.
  #delta_alpha: 0.2
  # Optional: Alpha value passed to cv2.accumulateWeighted when averaging frames to determine the background (default: shown below)
  # Higher values mean the current frame impacts the average a lot, and a new object will be averaged into the background faster.
  # Low values will cause things like moving shadows to be detected as motion for longer.
  # https://www.geeksforgeeks.org/background-subtraction-in-an-image-using-concept-of-running-average/
  #frame_alpha: 0.2
  # Optional: Height of the resized motion frame  (default: 50)
  # This operates as an efficient blur alternative. Higher values will result in more granular motion detection at the expense
  # of higher CPU usage. Lower values result in less CPU, but small changes may not register as motion.
  #frame_height: 50
  # Optional: motion mask
  # NOTE: see docs for more detailed info on creating masks
  #mask: 0,900,1080,900,1080,1920,0,1920
  # Optional: improve contrast (default: shown below)
  # Enables dynamic contrast improvement. This should help improve night detections at the cost of making motion detection more sensitive
  # for daytime.
  improve_contrast: True

objects:
  track:
    - person
    - car
    - motorcycle
    - cat
    - dog
  # filters:
  #   person:
  #     # Optional: minimum width*height of the bounding box for the detected object (default: 0)
  #     min_area: 5000
  #     # Optional: maximum width*height of the bounding box for the detected object (default: 24000000)
  #     max_area: 100000
  #     # Optional: minimum score for the object to initiate tracking (default: shown below)
  #     min_score: 0.5
  #     # Optional: minimum decimal percentage for tracked object's computed score to be considered a true positive (default: shown below)
  #     threshold: 0.7
  #     # Optional: mask to prevent this object type from being detected in certain areas (default: no mask)
  #     # Checks based on the bottom center of the bounding box of the object
  #     mask: 0,0,1000,0,1000,200,0,200

ffmpeg:
  global_args: -hide_banner -loglevel info
  # -hwaccel_output_format must be a native surface (e.g. vaapi, qsv)
  # and converted at the output step in order to use
  # hardware-accelerated filters like scale_vaapi.
  hwaccel_args: -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -hwaccel_output_format vaapi
  # Default input_args contains '-use_wallclock_as_timestamps 1', but
  # this causes ffmpeg to drop H.264 B-frames.
  input_args: -flags +low_delay -avoid_negative_ts make_zero -fflags +genpts+discardcorrupt+nobuffer+flush_packets -ec +guess_mvs+deblock+favor_inter -rtsp_transport tcp -timeout 10000000 -reorder_queue_size 1024
  # -avoid_negative_ts make_zero -fflags +genpts+discardcorrupt -rtsp_transport tcp -timeout 5000000 -use_wallclock_as_timestamps 1
  #
  #-flags +low_delay 
  output_args:
    detect: -vf scale_vaapi=w=1280:h=720,hwdownload,format=yuv420p -f rawvideo -pix_fmt yuv420p
    record: -f segment -segment_time 60 -segment_format mp4 -strftime 1 -reset_timestamps 1 -c copy
    #-an
    # transcode test
    #record: -f segment -segment_time 60 -segment_format mp4 -strftime 1 -reset_timestamps 1 -c:v h264_vaapi -an -profile:v high -bf 10 -level 60 -q 1 -rc_mode CQP -qp 22
    rtmp: -c copy -f flv

#ui:
#  use_experimental: true

cameras:
  driveway:
    ffmpeg:
      inputs:
        - path: rtsp://nvr:{FRIGATE_RTSP_PASSWORD}@cam-driveway.home/h264Preview_01_sub
          roles:
            - audio
        - path: rtsp://nvr:{FRIGATE_RTSP_PASSWORD}@cam-driveway.home/
          roles:
            - detect
            - record
            - rtmp
    mqtt: &reolink_mqtt_opts
      height: 540
      quality: 95
    motion:
      mask: &mask_driveway
        # timestamp
        #- 1363,44,1913,44,1913,12,1363,12
        - 909,29,1275,29,1275,8,909,8
        # foliage left
        #- 370,183,698,384,695,0,0,0,0,83
        - 247,122,465,256,463,0,0,0,0,55
        # foliage right
        #- 1254,253,1920,587,1920,0,793,0,781,150
        - 836,169,1280,391,1280,0,529,0,521,100
    objects:
      #mask: 892,244,1280,391,1280,0,529,0,521,100
      mask: 774,190,1280,617,1280,0,529,0,521,100
    zones:
      driveway_far:
        #coordinates: 1382,460,1172,225,961,225,910,460
        #coordinates: 921,307,781,150,641,150,607,307
        #coordinates: 1162,316,1042,41,905,45,885,324
        coordinates: 1186,363,1030,40,896,37,823,367
      driveway_near:
        #coordinates: 1382,460,1920,834,1920,1080,788,1080,910,460
        #coordinates: 921,307

This same root cause must be fixed before merging.
REVIEW_EOF
