#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `detect_objects.py`:

This pull request introduces the defect later reported as "Clips not working after upgrading from 0.7.0 rc3 to release". The
problem a user observed, and its root cause:

**Describe the bug**
Clips stopped getting stored in the /clips folder after upgrading to 0.7 release, I've found a balooning folder inside frigate /cache that now has 12GB of a lot of 1-2M files in it.

**Version of frigate**
blakeblackshear/frigate:0.7.0-aarch64

**Config file**
Include your full config file wrapped in back ticks.
```
web_port: 5000

mqtt:
  host: 192.168.1.10
  topic_prefix: rockfrigate
  client_id: rockfrigate

detectors:
  coral:
    type: edgetpu
    device: usb

objects:
  track:
    - person
    - car
  filters:
    person:
      min_area: 1000
      max_area: 100000
      threshold: 0.6
    car:
      min_area: 1000
      max_area: 100000
      threshold: 0.6
    
cameras:
  garage:
    ffmpeg:
      input: rtsp://192.168.1.10:8554/garage
    take_frame: 3
    snapshots:
      show_timestamp: False
      draw_bounding_boxes: True
    save_clips:
      enabled: True
      pre_capture: 10
    mqtt:
      crop_to_region: True

  back:
    ffmpeg:
      input: rtsp://192.168.1.10:8554/back
    take_frame: 3
    snapshots:
      show_timestamp: False
      draw_bounding_boxes: True
    save_clips:
      enabled: True
      pre_capture: 10
    mqtt:
      crop_to_region: True

  porch:
    ffmpeg:
      input: rtsp://192.168.1.10:8554/porch
    take_frame: 3
    snapshots:
      show_timestamp: False
      draw_bounding_boxes: True
    save_clips:
      enabled: True
      pre_capture: 10
    mqtt:
      crop_to_region: True
```

**Logs**
This might not be relevant, I have a camera with weak signal and drops connection a lot so this bit of log might be related to that, the weak signal hasn't caused any issues before though.
```
Exception in thread back:
Traceback (most recent call last):
  File "/usr/lib/python3.8/threading.py", line 932, in _bootstrap_inner
    self.run()
  File "/opt/frigate/frigate/video.py", line 180, in run
    capture_frames(self.ffmpeg_process, self.name, self.frame_shape, self.frame_manager, self.frame_queue, self.take_frame,
  File "/opt/frigate/frigate/video.py", line 130, in capture_frames
    frame_bytes = ffmpeg_process.stdout.read(frame_size)
ValueError: PyMemoryView_FromBuffer(): info->buf must not be NULL
```

```
Exception in thread Thread-6:
Traceback (most recent call last):
  File "/opt/frigate/frigate/events.py", line 147, in run
    event_type, camera, event_data = self.event_queue.get(timeout=10)
  File "/usr/lib/python3.8/multiprocessing/queues.py", line 108, in get
    raise Empty
_queue.Empty

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/lib/python3.8/threading.py", line 932, in _bootstrap_inner
    self.run()
  File "/opt/frigate/frigate/events.py", line 150, in run
    self.refresh_cache()
  File "/opt/frigate/frigate/events.py", line 43, in refresh_cache
    start_time = datetime.datetime.strptime(f.split('-')[-1].split('.')[0], '%Y%m%d%H%M%S')
  File "/usr/lib/python3.8/_strptime.py", line 568, in _strptime_datetime
    tt, fraction, gmtoff_fraction = _strptime(data_string, format)
  File "/usr/lib/python3.8/_strptime.py", line 349, in _strptime
    raise ValueError("time data %r does not match format %r" %
ValueError: time data 'qhgg5j' does not match format '%Y%m%d%H%M%S'
```

**Frigate debug stats**
```
{"back":{"camera_fps":14.8,"detection_fps":2.3,"ffmpeg_pid":5378,"frame_info":{"detect":1603097644.242771,"process":0.0,"read":1603097644.242771},"pid":70,"process_fps":5.0,"read_start":0.0,"skipped_fps":9.8},"detection_fps":5.4,"detectors":{"coral":{"detection_start":1603097644.279204,"inference_speed":21.98,"pid":22}},"garage":{"camera_fps":14.9,"detection_fps":1.1,"ffmpeg_pid":33,"frame_info":{"detect":1603097644.085345,"process":0.0,"read":1603097644.205714},"pid":69,"process_fps":5.0,"read_start":0.0,"skipped_fps":9.9},"porch":{"camera_fps":14.9,"detection_fps":2.0,"ffmpeg_pid":67,"frame_info":{"detect":1603097644.2433,"process":0.0,"read":1603097644.2433},"pid":71,"process_fps":5.0,"read_start":0.0,"skipped_fps":9.9}}

```


**Computer Hardware**
 - OS: Ubuntu
 - Virtualization: Docker
 - Coral Version: USB
 - Network Setup: Wired

**Camera Info:**
 - Manufacturer: Multiple
 - Model: Multiple
 - Resolution: 1080p
 - FPS: 15 

**Additional context**
It was working in RC3 but something has happened between that and release.
MQTT snapshots are still working, restarted frigate but the cache folder still seems to be growing.

This same root cause must be fixed before merging.
REVIEW_EOF
