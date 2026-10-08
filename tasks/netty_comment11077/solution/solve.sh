#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `handler/src/main/java/io/netty/handler/ssl/SslHandler.java` (around line 1973): `channel.unsafe().outboundBuffer()` may return `null` when a channel was closed we should add a null check.

```suggestion
            ChannelOutboundBuffer outboundBuffer = channel.unsafe().outboundBuffer();
            needsFlush |= fastOpen && outboundBuffer != null && outboundBuffer.totalPendingWriteBytes() > 0;
```
REVIEW_EOF
