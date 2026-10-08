#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `frigate/record.py`:

This pull request introduces the defect later reported as "[Support]: recordings on disk are in -4 timezone (4 hours behind UTC) - 0.12.0-beta2-tensorrt". The
problem a user observed, and its root cause:

### Describe the problem you are having

All my recordings on 0.12.0-beta2-tensorrt are recording with what appears to be a -4 timezone. I have checked my host and docker config which both display +10 (Australian Eastern Standard time). Everything in the GUI displays in my timezone as expected.

### Version

0.12.0-beta2-tensorrt (0.12.0-0DBF909)

### Frigate config file

```yaml
mqtt:
  host: 192.168.1.150
  port: 1883
cameras:
  garage-cam:
    ffmpeg:
      inputs:
        - path: rtsp://***:****@192.168.1.231:554/h265Preview_01_main
          roles:
            - detect
    detect:
      width: 3840 # <---- update for your camera's resolution
      height: 2160 # <---- update for your camera's resolution
  frontright-cam:
    ffmpeg:
      inputs:
        - path: rtsp://***:****@192.168.1.201:554/h265Preview_01_main
          roles:
            - detect
    detect:
      width: 3840 # <---- update for your camera's resolution
      height: 2160 # <---- update for your camera's resolution
  frontdoor-cam:
    # motion:
    #   mask:
    #     # top portion of frame (road + harry & joyce driveway)
    #     - 1083,0,0,0,0,197,0,594,108,521,391,368,673,235,893,222,1099,219,1369,213,1560,238,1788,254,2230,305,2709,387,3119,492,3421,565,3840,689,3840,537,3840,0,2595,0,1569,0
    ffmpeg:
      inputs:
        - path: rtsp://***:****@192.168.1.254:554/h265Preview_01_main
          roles:
            - detect
    detect:
      width: 3840 # <---- update for your camera's resolution
      height: 2160 # <---- update for your camera's resolution    
record:
  enabled: true
  retain:
    days: 7
    mode: all
snapshots:
  enabled: true
  retain:
    default: 90
birdseye:
  enabled: true
  mode: continuous
ffmpeg:
  # input_args: 
  hwaccel_args: preset-nvidia-h265
  # output_args: 
  # #   -an no audio
  # #   -crf default 28
  # #   -c:v codec for video
  # #   preset default medium
  #   record: -c:v libx265 -hwaccel hevc_cuvid -vf hwupload -f segment -segment_time 10 -segment_format mp4 -reset_timestamps 1 -strftime 1 -an -crf 26 -preset fast -pix_fmt yuv420p10le
detectors:
  tensorrt:
    type: tensorrt
    device: 0 #This is the default, select the first GPU
model:
  path: /trt-models/yolov7-tiny-416.trt
  labelmap_path: /trt-models/coco_91cl.txt
  input_tensor: nchw
  input_pixel_format: rgb
  width: 416
  height: 416
```


### Relevant log output

```shell
- frigate docker container
# zdump /etc/localtime
/etc/localtime  Thu Jan 12 10:58:55 2023 AEST

- unraid server
root@xxx:~# zdump /etc/localtime
/etc/localtime  Thu Jan 12 10:59:43 2023 AEST

- docker config
docker run
  -d
  --name='frigate-beta'
  --net='bridge'
  --privileged=true
  -e TZ="Australia/Brisbane"
  -e HOST_OS="Unraid"
  -e HOST_HOSTNAME="Thea"
  -e HOST_CONTAINERNAME="frigate-beta"
  -e 'FRIGATE_RTSP_PASSWORD'=''
  -l net.unraid.docker.managed=dockerman
  -l net.unraid.docker.webui='http://[IP]:[PORT:5000]'
  -l net.unraid.docker.icon='https://raw.githubusercontent.com/yayitazale/unraid-templates/main/frigate.png'
  -p '5051:5000/tcp'
  -p '1935:1935/tcp'
  -p '505:505/tcp'
  -v '/mnt/user/appdata/frigate-beta':'/config':'rw'
  -v '/mnt/user/surveillance/frigate-beta/':'/media/frigate':'rw'
  -v '/mnt/user/appdata/frigate-beta/trt-models':'/trt-models':'rw'
  -v '/etc/localtime':'/etc/localtime':'ro'
  --gpus all
  --shm-size=256mb
  --mount type=tmpfs,target=/tmp/cache,tmpfs-size=1000000000
  --restart unless-stopped 'blakeblackshear/frigate:0.12.0-beta2-tensorrt'
f75e5c20040257174b82a719194343839e8af0a33626bebcc17f0d410f1d5437
```


### FFprobe output from your camera

```shell
N/A
```


### Frigate stats

```json
N/A
```


### Operating system

UNRAID

### Install method

Docker Compose

### Coral version

CPU (no coral)

### Network connection

Wired

### Camera make and model

N/A

### Any other information that may be helpful

<img width="600" alt="image" src="https://user-images.githubusercontent.com/2231825/211950268-c04b5f85-c1a6-47c7-b653-b148eb71dd26.png">

Here we can see the timestamp of folders (hour 20) in the folder path, and the write time of the local system (hour 10, +10 AEST). UTC time is currently 12.

This same root cause must be fixed before merging.
REVIEW_EOF
