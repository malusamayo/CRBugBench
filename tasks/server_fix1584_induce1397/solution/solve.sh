#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `util/Setup/EnvironmentFileBuilder.cs`:

This pull request introduces the defect later reported as "Unhealthy SSo and events on Fresh 1.42.2". The
problem a user observed, and its root cause:

## Describe the Bug

I'm installing a fresh instance on an OpenSUSE 15.3 server. The SSO and the events containers seem to have issues as per the attached logs.

## Steps To Reproduce

1. Start from a fresh install on OpenSUSE 15.3
2. ./bitwarden.sh start
3. Visit the nginx port to confirm the instance has not started


## Expected Result

Bitwarden up and running

## Actual Result

Instance is un-operational

## Screenshots or Videos

```bash

 _     _ _                         _            
| |__ (_) |___      ____ _ _ __ __| | ___ _ __  
| '_ \| | __\ \ /\ / / _` | '__/ _` |/ _ \ '_ \ 
| |_) | | |_ \ V  V / (_| | | | (_| |  __/ | | |
|_.__/|_|\__| \_/\_/ \__,_|_|  \__,_|\___|_| |_|

Open source password management solutions
Copyright 2015-2021, 8bit Solutions LLC
https://bitwarden.com, https://github.com/bitwarden

===================================================

bitwarden.sh version 1.42.2
Docker version 20.10.6-ce, build 8728dd246c3a
docker-compose version 1.25.1, build a82fef0

Pulling mssql         ... done
Pulling web           ... done
Pulling attachments   ... done
Pulling api           ... done
Pulling identity      ... done
Pulling sso           ... done
Pulling admin         ... done
Pulling portal        ... done
Pulling icons         ... done
Pulling notifications ... done
Pulling events        ... done
Pulling nginx         ... done
Creating network "docker_default" with the default driver
Creating network "docker_public" with the default driver
Creating bitwarden-events        ... done
Creating bitwarden-notifications ... done
Creating bitwarden-api           ... done
Creating bitwarden-icons         ... done
Creating bitwarden-attachments   ... done
Creating bitwarden-sso           ... done
Creating bitwarden-web           ... done
Creating bitwarden-mssql         ... done
Creating bitwarden-identity      ... done
Creating bitwarden-admin         ... done
Creating bitwarden-portal        ... done
Creating bitwarden-nginx         ... done
1.42.2: Pulling from bitwarden/setup
e1acddbe380c: Already exists 
dd03aafcc609: Already exists 
42dd948b1ee9: Already exists 
babf609d748c: Already exists 
62b1be457df2: Already exists 
60a368b9234b: Pull complete 
209d6ada8786: Pull complete 
d6c0456df1ae: Pull complete 
11208cf07c5e: Pull complete 
56a76ad8352a: Pull complete 
Digest: sha256:5153e89a92e7e03c69fc5174b699b37173bfaeaf4c15d18a7e7b9f139b6ec3b7
Status: Downloaded newer image for bitwarden/setup:1.42.2
docker.io/bitwarden/setup:1.42.2


Bitwarden is up and running!
===================================================

visit https://bitwarden.girgis.me
to update, run `./bitwarden.sh updateself` and then `./bitwarden.sh update`
```

Containers' logs:

- [_bitwarden-events_logs.txt](https://github.com/bitwarden/server/files/7070162/_bitwarden-events_logs.txt)
- [_bitwarden-sso_logs.txt](https://github.com/bitwarden/server/files/7070163/_bitwarden-sso_logs.txt)

The containers also show up as "unhealthy" as shown below:

![docker](https://user-images.githubusercontent.com/8952124/131206965-74e72b5c-3a6a-4d88-a4e3-1b4a35814442.png)

When I navigate to the instance, I get this error:

![gtaeway](https://user-images.githubusercontent.com/8952124/131207079-1f16d65e-0238-41bd-80fa-ad851eb2836a.png)

## Environment

- Operating system: OpenSUSE 15.3
- Build Version: 1.42.2
- Self Hosted: true
- Environment: Docker
- Hardware: 
  - CPU(s): 12 x Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz (2 Sockets)
  - RAM: 48 GB ECC

## Additional Context

N/A

This same root cause must be fixed before merging.
REVIEW_EOF
