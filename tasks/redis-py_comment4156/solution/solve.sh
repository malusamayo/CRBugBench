#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `redis/_parsers/hiredis.py` (around line 70): Could you also handle POLLRDHUP? 
Note it has to be added to the poller.register() mask, not just the returned-events check, or poll() won't report it.  Guard it with getattr(select, "POLLRDHUP", 0) so macOS/Windows keep relying on POLLHUP.
On Linux, a graceful peer close (FIN) reports POLLIN|POLLRDHUP, not POLLHUP, so _socket_is_closed() currently returns False and the stale connection is still reused. Current solution covers macOS/BSD (they set POLLHUP on FIN) but not Linux.

Also, the socketpair() tests use AF_UNIX, which sets POLLHUP on close just like macOS — so they pass even though the Linux TCP path isn't detected. Could you add a regression test that will cover this addition? That will fail on the current code and pass once POLLRDHUP is handled.
REVIEW_EOF
