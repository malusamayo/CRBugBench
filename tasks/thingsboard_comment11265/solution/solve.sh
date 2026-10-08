#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `common/transport/transport-api/src/main/java/org/thingsboard/server/common/transport/service/DefaultTransportService.java` (around line 691): ### Long story short
It is too late to verify the message size at this stage. In a DDoS case, you may already be OOM at this moment.
### TL;DR
You should check RAW payload size as early as possible.
The proto you check is already prepared be some code earlier.
The main goal is to not use any memory before the max_message_size  chack passed.

Transports uses some protocols and libraries. I believe some of them already allows to set a hard limit for payload in bytes on the lowest level possible. For example , max buffer size or so. 
Imagine you are receiving a 1GiG RPC request. The channel would rather not receive the whole 1GiG and then do some checks. You simply might not have the memory or network bandwidth to handle even a few parallel requests.

If the channel gives up immediately after exceeding the payload limit - it will be the best solution possible.

If the channel does not provide an option to check the msg limit - check the payload raw size as soon as possible before any transformations.

![image](https://github.com/user-attachments/assets/d0b353a0-028a-41b3-aeaf-079484e9203d)
REVIEW_EOF
