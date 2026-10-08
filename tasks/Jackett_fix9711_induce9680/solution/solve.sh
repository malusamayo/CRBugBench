#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Jackett.Common/Indexers/BroadcasTheNet.cs`:

This pull request introduces the defect later reported as "[broadcasthenet] Object reference not set to an instance of an object. (Config)". The
problem a user observed, and its root cause:

### Environment

**OS**: Unraid 

**.Net Runtime**: [.Net-Core/.Net-Framework/Mono]

**.Net Version**: Unsure? Whatever comes in the amd64 linux binary package Linuxserver.io uses

**Jackett Version**: 0.16.1472

**Last Working Jackett Version**: 0.16.1451

**Are you using a proxy or VPN?** no

### Description

Looks like pull request #9680 may have broken BTN on 0.16.1472 using latest linuxserver's docker image. Reverting back to 0.16.1451 works normally


### Logged Error Messages
[btnError.txt](https://github.com/Jackett/Jackett/files/5314627/btnError.txt)

This same root cause must be fixed before merging.
REVIEW_EOF
