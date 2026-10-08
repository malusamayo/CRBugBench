#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `mobile/lib/presentation/widgets/asset_viewer/bottom_sheet/sheet_people_details.widget.dart`:

This pull request introduces the defect later reported as "Age display gets cutoff in some cases". The
problem a user observed, and its root cause:

### I have searched the existing issues, both open and closed, to make sure this is not a duplicate report.

- [x] Yes

### The bug

In Bata Timeline mode:

For children under one year old, the system cannot display their age in months and instead directly converts the number of months since birth into years.
7 months old becomes Age 7.

### The OS that Immich Server is running on

QNAP

### Version of Immich Server

1.137.3

### Version of Immich Mobile App

1.137.3

### Platform with the issue

- [ ] Server
- [ ] Web
- [x] Mobile

### Your docker-compose.yml content

```YAML
#
# WARNING: To install Immich, follow our guide: https://immich.app/docs/install/docker-compose
#
# Make sure to use the docker-compose.yml of the current release:
#
# https://github.com/immich-app/immich/releases/latest/download/docker-compose.yml
#
# The compose file on main may not be compatible with the latest release.

name: immich

services:
  immich-server:
    container_name: immich_server
    image: ghcr.io/immich-app/immich-server:${IMMICH_VERSION:-release}
    extends:
      file: hwaccel.transcoding.yml
      service: quicksync # set to one of [nvenc, quicksync, rkmpp, vaapi, vaapi-wsl] for accelerated transcoding
    volumes:
      # Do not edit the next line. If you want to change the media storage location on your system, edit the value of UPLOAD_LOCATION in the .env file
      - ${UPLOAD_LOCATION}:/data
      - /etc/localtime:/etc/localtime:ro

      # 自整理相簿
      - ${EXTLIB_LOCATION_1}:/Photo_Album/鄭旭宏
      - ${EXTLIB_LOCATION_2}:/Photo_Album/鄭夙惠
      
      # QNAP上傳照片
      - ${QNAP_UPLOAD_shiuh}:/Photo_Album_QNAP/鄭旭宏
      - ${QNAP_UPLOAD_nancy}:/Photo_Album_QNAP/錢柏樺
      - ${QNAP_UPLOAD_ethon}:/Photo_Album_QNAP/鄭宇辰
      - ${QNAP_UPLOAD_jina}:/Photo_Album_QNAP/鄭子清

      - ${QNAP_UPLOAD_maygd92}:/Photo_Album_QNAP/劉凱倫
      - ${QNAP_UPLOAD_gd92may}:/Photo_Album_QNAP/鄭夙惠
      - ${QNAP_UPLOAD_stella}:/Photo_Album_QNAP/劉鎰瑄
      
      - ${EXTLIB_geodata}:/build/geodata:ro
      - ${EXTLIB_i18n_iso_countries}:/usr/src/app/node_modules/i18n-iso-countries/langs:ro
    env_file:
      - .env
    ports:
      - '2283:2283'
    depends_on:
      - redis
      - database
    restart: always
    healthcheck:
      disable: false

  immich-machine-learning:
    container_name: immich_machine_learning
    # For hardware acceleration, add one of -[armnn, cuda, rocm, openvino, rknn] to the image tag.
    # Example tag: ${IMMICH_VERSION:-release}-cuda
    image: ghcr.io/immich-app/immich-machine-learning:${IMMICH_VERSION:-release}
    # extends: # uncomment this section for hardware acceleration - see https://immich.app/docs/features/ml-hardware-acceleration
    #   file: hwaccel.ml.yml
    #   service: cpu # set to one of [armnn, cuda, rocm, openvino, openvino-wsl, rknn] for accelerated inference - use the `-wsl` version for WSL2 where applicable
    volumes:
      - model-cache:/cache
    env_file:
      - .env
    restart: always
    healthcheck:
      disable: false

  redis:
    container_name: immich_redis
    image: docker.io/valkey/valkey:8-bookworm@sha256:facc1d2c3462975c34e10fccb167bfa92b0e0dbd992fc282c29a61c3243afb11
    healthcheck:
      test: redis-cli ping || exit 1
    restart: always

  database:
    container_name: immich_postgres
    image: ghcr.io/immich-app/postgres:14-vectorchord0.4.3-pgvectors0.2.0@sha256:32324a2f41df5de9efe1af166b7008c3f55646f8d0e00d9550c16c9822366b4a
    environment:
      POSTGRES_PASSWORD: ${DB_PASSWORD}
      POSTGRES_USER: ${DB_USERNAME}
      POSTGRES_DB: ${DB_DATABASE_NAME}
      POSTGRES_INITDB_ARGS: '--data-checksums'
      # Uncomment the DB_STORAGE_TYPE: 'HDD' var if your database isn't stored on SSDs
      # DB_STORAGE_TYPE: 'HDD'
    volumes:
      # Do not edit the next line. If you want to change the database storage location on your system, edit the value of DB_DATA_LOCATION in the .env file
      - ${DB_DATA_LOCATION}:/var/lib/postgresql/data
    shm_size: 128mb
    restart: always

volumes:
  model-cache:
```

### Your .env content

```Shell
# You can find documentation for all the supported env variables at https://immich.app/docs/install/environment-variables

# The location where your uploaded files are stored
UPLOAD_LOCATION=/share/upload_photo/immich_upload

# The location where your database files are stored
DB_DATA_LOCATION=/share/Container/config/immich/postgres

# 延伸支援資料夾 團體整理照片
EXTLIB_LOCATION_1=/share/Backup/鄭旭宏/照片存檔區/相簿
EXTLIB_LOCATION_2=/share/Backup/鄭夙惠/家庭相簿

# 延伸支援 QNAP 上傳照片資料夾
QNAP_UPLOAD_shiuh=/share/upload_photo/鄭旭宏
QNAP_UPLOAD_nancy=/share/upload_photo/錢柏樺
QNAP_UPLOAD_ethon=/share/upload_photo/鄭宇辰
QNAP_UPLOAD_jina=/share/upload_photo/鄭子清

QNAP_UPLOAD_maygd92=/share/upload_photo/劉凱倫
QNAP_UPLOAD_gd92may=/share/upload_photo/鄭夙惠
QNAP_UPLOAD_stella=/share/upload_photo/劉鎰瑄


#台灣繁體中文地區名稱
EXTLIB_geodata=/share/Container/config/immich/temp/geodata
EXTLIB_i18n_iso_countries=/share/Container/config/immich/temp/i18n-iso-countries/langs

# To set a timezone, uncomment the next line and change Etc/UTC to a TZ identifier from this list: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List
TZ=Asia/Taipei

# The Immich version to use. You can pin this to a specific version like "v1.132.3" or "release"
IMMICH_VERSION=release

# Connection secret for postgres. You should change it to a random password
# Please use only the characters `A-Za-z0-9`, without special characters or spaces
DB_PASSWORD=postgres

# The values below this line do not need to be changed
###################################################################################
DB_USERNAME=postgres
DB_DATABASE_NAME=immich
```

### Reproduction steps

![Image](https://github.com/user-attachments/assets/c9d147c9-4c7a-49f5-aaa8-8d7972527feb)
![Image](https://github.com/user-attachments/assets/79b5e75f-3ee3-405f-8d69-d060e0044b3f)

1.Switch to Bata Timeline mode
2.Find photos of children under one year old
3.Check the People information in the photos
...


### Relevant log output

```shell

```

### Additional information

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
