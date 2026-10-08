#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `frigate/detectors/plugins/rknn.py`:

This pull request introduces the defect later reported as "[Support]: When restarting Frigate, it raises AttributeError: 'Rknn' object has no attribute 'rknn' ". The
problem a user observed, and its root cause:

### Describe the problem you are having

Hi, something for the dev branch again with an orange pi 5 plus.


I noticed that when saving the config and restarting frigate or even just triggering the restart frigate command from the 3 dot menu, I get this error.  When stopping the container and starting it again it doesnt exhibit this issue.


![image](https://github.com/blakeblackshear/frigate/assets/467007/d99f9521-2720-4d89-a96e-38a118e6331f)

### Version

0.13.0-4879DE26

### Frigate config file

```yaml
detectors:
  rknn:
    type: rknn
    # core mask for npu
    core_mask: 0b011

model:
  #path: default-yolov8n
  path: /models/yolov8n-320x320.rknn
  width: 320
  height: 320
  input_pixel_format: bgr             # required
  input_tensor: nhwc

go2rtc:
  streams:
    balcony:
    - rtsp://user:pass@ip/stream1
    - ffmpeg:rtsp_cam#audio=opus

  balcony:
    ffmpeg:
      output_args:
        record: preset-record-generic-audio-copy
      inputs:
      - path: rtsp://127.0.0.1:8554/balcony
        roles: 
          - detect
    detect:
      enabled: true
    objects:
      track:
        - person
        - cat
        - bird
        - dog
        - car
```


### Relevant log output

```shell
2023-11-18 17:31:55.004766507  192.168.0.13 - - [18/Nov/2023:17:31:55 +0000] "GET /api/labels?camera=balcony HTTP/1.1" 502 559 "http://192.168.0.15:5000/cameras/balcony" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36" "-"
2023-11-18 17:31:55.073699983  2023/11/18 17:31:55 [error] 145#145: *21 connect() failed (111: Connection refused) while connecting to upstream, client: 192.168.0.13, server: , request: "GET /ws HTTP/1.1", upstream: "http://127.0.0.1:5002/", host: "192.168.0.15:5000"
2023-11-18 17:31:55.073705233  192.168.0.13 - - [18/Nov/2023:17:31:55 +0000] "GET /ws HTTP/1.1" 502 559 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36" "-"
2023-11-18 17:31:55.346267880  2023/11/18 17:31:55 [error] 166#166: *10 connect() failed (111: Connection refused) while connecting to upstream, client: 192.168.0.125, server: , request: "GET /api/stats HTTP/1.1", upstream: "http://127.0.0.1:5001stats", host: "192.168.0.15:5000"
2023-11-18 17:31:56.811122136  [2023-11-18 17:31:56] peewee_migrate.logs            INFO    : Starting migrations
2023-11-18 17:31:56.848750380  [2023-11-18 17:31:56] peewee_migrate.logs            INFO    : There is nothing to migrate
2023-11-18 17:31:56.926112344  [2023-11-18 17:31:56] detector.rknn                  INFO    : Starting detection process: 495
2023-11-18 17:31:56.928446818  Process detector:rknn:
2023-11-18 17:31:56.930406213  Traceback (most recent call last):
2023-11-18 17:31:56.930506545    File "/usr/lib/python3.9/multiprocessing/process.py", line 315, in _bootstrap
2023-11-18 17:31:56.930510336      self.run()
2023-11-18 17:31:56.930521711    File "/usr/lib/python3.9/multiprocessing/process.py", line 108, in run
2023-11-18 17:31:56.930526378      self._target(*self._args, **self._kwargs)
2023-11-18 17:31:56.930566336    File "/opt/frigate/frigate/object_detection.py", line 102, in run_detector
2023-11-18 17:31:56.930570419      object_detector = LocalObjectDetector(detector_config=detector_config)
2023-11-18 17:31:56.930573627    File "/opt/frigate/frigate/object_detection.py", line 53, in __init__
2023-11-18 17:31:56.930576252      self.detect_api = create_detector(detector_config)
2023-11-18 17:31:56.930580044    File "/opt/frigate/frigate/detectors/__init__.py", line 18, in create_detector
2023-11-18 17:31:56.930618835      return api(detector_config)
2023-11-18 17:31:56.930622335    File "/opt/frigate/frigate/detectors/plugins/rknn.py", line 68, in __init__
2023-11-18 17:31:56.930626710      os.rename("/usr/lib/librknnrt_rk3588.so", "/usr/lib/librknnrt.so")
2023-11-18 17:31:56.930630502  FileNotFoundError: [Errno 2] No such file or directory: '/usr/lib/librknnrt_rk3588.so' -> '/usr/lib/librknnrt.so'
2023-11-18 17:31:56.930693501  Exception ignored in: <function Rknn.__del__ at 0xffff82dd59d0>
2023-11-18 17:31:56.930697001  Traceback (most recent call last):
2023-11-18 17:31:56.930699918    File "/opt/frigate/frigate/detectors/plugins/rknn.py", line 135, in __del__
2023-11-18 17:31:56.931028331      self.rknn.release()
2023-11-18 17:31:56.931032706  AttributeError: 'Rknn' object has no attribute 'rknn'
2023-11-18 17:31:58.666386423  [INFO] Starting go2rtc healthcheck service...
```


when it starts up, rknn detector loads fine
```shell
2023-11-18 17:41:53.039059490  [2023-11-18 17:41:53] peewee_migrate.logs            INFO    : Starting migrations
2023-11-18 17:41:53.041389005  [2023-11-18 17:41:53] peewee_migrate.logs            INFO    : There is nothing to migrate
2023-11-18 17:41:53.098813735  [2023-11-18 17:41:53] detector.rknn                  INFO    : Starting detection process: 493
2023-11-18 17:41:53.463825219  I RKNN: [17:41:53.463] RKNN Runtime Information: librknnrt version: 1.5.2 (c6b7b351a@2023-08-23T15:28:22)
2023-11-18 17:41:53.463980967  I RKNN: [17:41:53.463] RKNN Driver Information: version: 0.9.0
2023-11-18 17:41:53.464515586  I RKNN: [17:41:53.464] RKNN Model Information: version: 6, toolkit version: 1.5.2+b642f30c(compiler version: 1.5.2 (c6b7b351a@2023-08-23T07:39:01)), target: RKNPU v2, target platform: rk3588, framework name: ONNX, framework layout: NCHW, model inference type: static_shape
2023-11-18 17:41:54.468640016  [INFO] Starting go2rtc healthcheck service...
```
### FFprobe output from your camera

```shell
ffprobe version e243e8d001-20231113 Copyright (c) 2007-2023 the FFmpeg developers
  built with gcc 13.2.0 (crosstool-NG 1.25.0.232_c175b21)
  configuration: --prefix=/ffbuild/prefix --pkg-config-flags=--static --pkg-config=pkg-config --cross-prefix=aarch64-ffbuild-linux-gnu- --arch=aarch64 --target-os=linux --enable-nonfree --enable-gpl --enable-version3 --disable-debug --enable-iconv --enable-libxml2 --enable-zlib --enable-libfreetype --enable-libfribidi --enable-gmp --enable-openssl --enable-lzma --enable-fontconfig --enable-libvorbis --enable-opencl --enable-libpulse --enable-libvmaf --enable-libxcb --enable-xlib --enable-amf --enable-libaom --enable-libaribb24 --enable-avisynth --enable-chromaprint --enable-libdav1d --disable-libdavs2 --enable-libdrm --enable-libfdk-aac --enable-ffnvcodec --enable-cuda-llvm --enable-frei0r --enable-libgme --enable-libkvazaar --enable-libass --enable-libbluray --disable-libjxl --enable-libmp3lame --enable-libopus --enable-librist --enable-libssh --enable-libtheora --disable-libvpx --enable-libwebp --enable-lv2 --enable-rkmpp --disable-libvpl --enable-openal --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libopenh264 --enable-libopenjpeg --enable-libopenmpt --enable-librav1e --enable-librubberband --disable-schannel --enable-sdl2 --enable-libsoxr --enable-libsrt --enable-libsvtav1 --enable-libtwolame --enable-libuavs3d --enable-libdrm --disable-vaapi --enable-libvidstab --enable-vulkan --enable-libshaderc --disable-libplacebo --enable-libx264 --enable-libx265 --disable-libxavs2 --enable-libxvid --enable-libzimg --enable-libzvbi --extra-cflags=-DLIBTWOLAME_STATIC --extra-cxxflags= --extra-ldflags=-pthread --extra-ldexeflags=-pie --extra-libs='-ldl -lstdc++ -lgomp' --extra-version=20231113
  libavutil      58.  2.100 / 58.  2.100
  libavcodec     60.  3.100 / 60.  3.100
  libavformat    60.  3.100 / 60.  3.100
  libavdevice    60.  1.100 / 60.  1.100
  libavfilter     9.  3.100 /  9.  3.100
  libswscale      7.  1.100 /  7.  1.100
  libswresample   4. 10.100 /  4. 10.100
  libpostproc    57.  1.100 / 57.  1.100
Input #0, rtsp, from 'rtsp://dvrusr:senbonzakura@192.168.0.232:554/stream1':
  Metadata:
    title           : Session streamed by "TP-LINK RTSP Server"
  Duration: N/A, start: 0.000000,

This same root cause must be fixed before merging.
REVIEW_EOF
