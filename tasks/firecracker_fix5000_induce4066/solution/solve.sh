#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/vmm/src/devices/virtio/queue.rs`:

This pull request introduces the defect later reported as "Misleading comment about where the queue starts and its size". The
problem a user observed, and its root cause:

Hello,

IIUC, the virtqueue starts at QUEUE_BASE_ADDRESS, which is not `0`. So the comment shall state that. The comment is at 
https://github.com/firecracker-microvm/firecracker/blob/94826a8d7de32fc871945b7ee088f1f7d3c8a4cc/src/vmm/src/devices/virtio/queue.rs#L879

Also QUEUE_END is not the size if the starting address is not zero so the definition at https://github.com/firecracker-microvm/firecracker/blob/94826a8d7de32fc871945b7ee088f1f7d3c8a4cc/src/vmm/src/devices/virtio/queue.rs#L809 may be wrong.  

Thanks.

This same root cause must be fixed before merging.
REVIEW_EOF
