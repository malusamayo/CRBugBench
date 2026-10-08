#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `docker/images/n8n/Dockerfile`:

This pull request introduces the defect later reported as "Version of Docker image - missing info". The
problem a user observed, and its root cause:

### Bug Description

Hello,
for some time you do not provide a version of the Docker image (docker inspect n8nio/n8n:latest), why?

![Image](https://github.com/user-attachments/assets/10b45018-7868-44fc-a5a4-e0ee4ddbacdb)

I have automation for checking newer version n8n than my instance and now doesn’t work.

Regards

### To Reproduce

docker pull n8nio/n8n:latest
docker inspect n8nio/n8n:latest | grep org.opencontainers.image.version

### Expected behavior

Set version of n8n in Docker image as before.

### Operating System

Debian 10

### n8n Version

1.95.3

### Node.js Version

20.19.2

### Database

SQLite (default)

### Execution mode

main (default)

This same root cause must be fixed before merging.
REVIEW_EOF
