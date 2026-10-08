#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `transports/quic/src/transport.rs`:

This pull request introduces the defect later reported as "quic: returning ListenerClosed on connection closed internally". The
problem a user observed, and its root cause:

## Current behaviour

In lighthouse while trying to shutdown the client, [SwarmEvent::Listenerclosed](https://github.com/sigp/lighthouse/blob/441fc1691b69f9edc4bbdc6665f3efab16265c9b/beacon_node/lighthouse_network/src/service/mod.rs#L1535-L1544) was returned and logged:
```
CRIT Listener closed reason: Err(Custom { kind: Other, error: Transport(Custom { kind: Other, error: Right(EndpointDriverCrashed) }) }), addresses: [\"/ip4/127.0.0.1/udp/9001/quic-v1\", \"/ip4/141.95.85.227/udp/9001/quic-v1\"], service: libp2p
```
In the `quic` transport, when polling the `Listener` :
https://github.com/libp2p/rust-libp2p/blob/399eaa39156f756956f38fab20083293da826fdd/transports/quic/src/transport.rs#L573-L595

as `quinn` (unlike tokio's `TcpStream` which cannot be closed) [`Accept`](https://docs.rs/quinn/0.10.2/quinn/struct.Accept.html) `Future` impl is `Option`, it yields `None` when the endpoint has been closed and `quic::Transport` returns `SwarmEvent::ListenerClosed`.

This is different from the other transports, namely `tcp` which only returns `SwarmEvent::ListenerClosed` when `Transport::remove_listener` is called.


## Possible Solution
Can we not send `SwarmEvent::ListenerClosed` when `Accept` returns `None` and just return `Poll::Ready(None)` to match other transports? @kpp what was the reason for considering `Accept` returning `None` a `EndpointDriverCrashed` ?

thanks
## Version
<!--
Which version of libp2p are you using?
-->

- libp2p version (version number, commit, or branch):


## Would you like to work on fixing this bug?

<!--Any contribution towards fixing the bug is greatly appreciated.
We are more than happy to provide help on the process.-->

Yes

This same root cause must be fixed before merging.
REVIEW_EOF
