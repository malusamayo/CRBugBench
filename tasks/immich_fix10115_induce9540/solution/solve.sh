#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `web/src/routes/(user)/utilities/[duplicates]/[[photos=photos]]/[[assetId=id]]/+page.svelte`:

This pull request introduces the defect later reported as "Processing duplicate images with unprevileged account fails due to permission error". The
problem a user observed, and its root cause:

### The bug

Submitting selection of image when using the new image deduplication fails due to permission error for unprivileged users.

Right after submitting the selection, the following error shows up inside the container logs:
```text
WARN [Api:AuthGuard~un5bgh0e] Denied access to admin only route: /api/system-config
```

Thank you A LOT for creating this absolutely awesome piece of software :heart:
If you need any futher information please let me know :)

### The OS that Immich Server is running on

Debian 12.5, Linux 6.1.0-21-amd64

### Version of Immich Server

v1.160.1

### Version of Immich Mobile App

n/a

### Platform with the issue

- [X] Server
- [X] Web
- [ ] Mobile

### Your docker-compose.yml content

```YAML
name: immich

services:
  immich-server:
    container_name: immich_server
    image: ghcr.io/immich-app/immich-server:${IMMICH_VERSION:-release}
    volumes:
      - ${UPLOAD_LOCATION}:/usr/src/app/upload
      - /etc/localtime:/etc/localtime:ro
    env_file:
      - .env
    ports:
      - 2283:3001
    depends_on:
      - redis
      - database
    restart: always

  immich-machine-learning:
    container_name: immich_machine_learning
    image: ghcr.io/immich-app/immich-machine-learning:${IMMICH_VERSION:-release}
    volumes:
      - model-cache:/cache
    env_file:
      - .env
    restart: always

  redis:
    container_name: immich_redis
    image: registry.hub.docker.com/library/redis:6.2-alpine@sha256:84882e87b54734154586e5f8abd4dce69fe7311315e2fc6d67c29614c8de2672
    restart: always

  database:
    container_name: immich_postgres
    image: registry.hub.docker.com/tensorchord/pgvecto-rs:pg14-v0.2.0@sha256:90724186f0a3517cf6914295b5ab410db9ce23190a2d9d0b9dd6463e3fa298f0
    environment:
      POSTGRES_PASSWORD: ${DB_PASSWORD}
      POSTGRES_USER: ${DB_USERNAME}
      POSTGRES_DB: ${DB_DATABASE_NAME}
      POSTGRES_INITDB_ARGS: '--data-checksums'
    volumes:
      - ${DB_DATA_LOCATION}:/var/lib/postgresql/data
    restart: always
    command: ["postgres", "-c" ,"shared_preload_libraries=vectors.so", "-c", 'search_path="$$user", public, vectors', "-c", "logging_collector=on", "-c", "max_wal_size=2GB", "-c", "shared_buffers=512MB", "-c", "wal_compression=on"]

volumes:
  model-cache:
```


### Your .env content

```Shell
UPLOAD_LOCATION=./library
DB_DATA_LOCATION=./postgres
IMMICH_VERSION=v1.106.1
DB_PASSWORD=<redacted>
DB_USERNAME=postgres
DB_DATABASE_NAME=immich
```


### Reproduction steps

```bash
After upgrading from v1.105.1 to v1.106.1 ...

Perform once:
1. Log into the web interface as admin
2. Trigger the `Duplicate Detection` task for existing media

Steps to reproduce:
1. Log into the web interface as unprivileged (non-admin) user
2. Navigate to `Library` > `Utilities`
3. Select `Review duplicates`
4. Perform any selection (does not matter)
5. Click the submit button (Trash or Keep)
6. See "Error: Forbidden resource (Immich Server Error)" pop up at the top-right corner of the screen
```


### Relevant log output

```shell
immich_server            | [Nest] 17  - 06/11/2024, 10:38:46 AM     LOG [Api:EventRepository] Websocket Connect:    qartrFOG-jA1wqTfAAAR
immich_server            | [Nest] 17  - 06/11/2024, 10:38:46 AM    WARN [Api:AuthGuard~un5bgh0e] Denied access to admin only route: /api/system-config
```


### Additional information

Screenshot of the error message in the web UI:
![image](https://github.com/immich-app/immich/assets/326180/1c62ea41-88d2-46b3-ad60-c95883269bef)

This same root cause must be fixed before merging.
REVIEW_EOF
