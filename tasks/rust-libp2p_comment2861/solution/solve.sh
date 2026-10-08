#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `swarm/src/connection.rs` (around line 286): I am afraid this leads to a deadlock with the current Yamux implementation.

`<Yamux as StreamMuxer>::poll` currently only returns `Poll::Pending`, but does not drive the underlying state machine.

https://github.com/libp2p/rust-libp2p/blob/b8c3b282eee5d6387a9cf2f64af0253e764c1172/muxers/yamux/src/lib.rs#L126-L131

The only `StreamMuxer` method driving the Yamux state machine is `<Yamux as StreamMuxer>::poll_inbound`:

https://github.com/libp2p/rust-libp2p/blob/b8c3b282eee5d6387a9cf2f64af0253e764c1172/muxers/yamux/src/lib.rs#L104-L115

Note that the Yamux state machine is the component reading and writing from/to the underlying I/O resource.

Thus, once the `self.max_negotiating_inbound_streams` limit is hit, established streams and pending outbound streams will no longer make progress.

---

**Suggestion**

Yamux does not support back-pressure on stream creation at the protocol level. Thus, the only thing a node can do is drop inbound streams. The question is where to drop inbound streams.

Ideally I would like to drop streams within https://github.com/libp2p/rust-yamux once a certain limit is hit. We could as well buffer streams in `libp2p-yamux::Yamux` and drop streams exceeding the limit there.
REVIEW_EOF
