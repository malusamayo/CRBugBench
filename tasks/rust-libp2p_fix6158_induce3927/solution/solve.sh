#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `misc/metrics/src/swarm.rs`:

This pull request introduces the defect later reported as "Metric collection for swarm event panics". The
problem a user observed, and its root cause:

### Summary

Calling `record(&SwarmEvent)` panics with the following message:
```
thread 'tokio-runtime-worker' panicked at /usr/local/cargo/registry/src/index.crates.io-6f17d22bba15001f/libp2p-metrics-0.16.0/src/swarm.rs:236:26:
closed connection to previously be established
```

I'm calling `record` on each event I'm getting from `swarm.select_next_some()`.

### Expected behavior

Metrics collection should never panic

### Actual behavior

Panics [here](https://github.com/libp2p/rust-libp2p/blob/1755bca475928ad0e603c42b98c29107c88816cb/misc/metrics/src/swarm.rs#L236): `closed connection to previously be established`

### Relevant log output

<details>
<summary>Logs</summary>

```shell
2025-08-26T09:30:21.043590169Z Swarm event: NewListenAddr { listener_id: ListenerId(1), address: /ip4/127.0.0.1/udp/12345/quic-v1 }
2025-08-26T09:30:21.043604165Z Swarm event: NewListenAddr { listener_id: ListenerId(1), address: /ip4/10.233.127.195/udp/12345/quic-v1 }
2025-08-26T09:30:21.044143360Z Swarm event: Behaviour(LogListeners { listeners: [] })
2025-08-26T09:30:21.064841051Z Swarm event: ConnectionEstablished { peer_id: PeerId("12D3KooWSRvKpvNbsrGbLXGFZV7GYdcrYNh4W2nipwHHMYikzV58"), connection_id: ConnectionId(1), endpoint: Dialer { address: /dns4/testnet.subsquid.io/udp/22445/quic-v1/p2p/12D3KooWSRvKpvNbsrGbLXGFZV7GYdcrYNh4W2nipwHHMYikzV58, role_override: Dialer, port_use: Reuse }, num_established: 1, concurrent_dial_errors: Some([]), established_in: 21.581685ms }
2025-08-26T09:30:21.066446903Z Swarm event: ConnectionEstablished { peer_id: PeerId("12D3KooWQC9tPzj2ShLn39RFHS5SGbvbP2pEd7bJ61kSW2LwxGSB"), connection_id: ConnectionId(2), endpoint: Dialer { address: /dns4/testnet.subsquid.io/udp/22446/quic-v1/p2p/12D3KooWQC9tPzj2ShLn39RFHS5SGbvbP2pEd7bJ61kSW2LwxGSB, role_override: Dialer, port_use: Reuse }, num_established: 1, concurrent_dial_errors: Some([]), established_in: 23.202546ms }
2025-08-26T09:30:21.079487420Z Swarm event: NewExternalAddrOfPeer { peer_id: PeerId("12D3KooWSRvKpvNbsrGbLXGFZV7GYdcrYNh4W2nipwHHMYikzV58"), address: /ip4/127.0.0.1/udp/22445/quic-v1 }
2025-08-26T09:30:21.079534649Z Swarm event: NewExternalAddrOfPeer { peer_id: PeerId("12D3KooWSRvKpvNbsrGbLXGFZV7GYdcrYNh4W2nipwHHMYikzV58"), address: /ip4/10.6.3.21/udp/22445/quic-v1 }
2025-08-26T09:30:21.079552863Z Swarm event: NewExternalAddrCandidate { address: /ip4/162.19.121.18/udp/2489/quic-v1 }
2025-08-26T09:30:21.079922409Z Swarm event: NewExternalAddrOfPeer { peer_id: PeerId("12D3KooWQC9tPzj2ShLn39RFHS5SGbvbP2pEd7bJ61kSW2LwxGSB"), address: /ip4/127.0.0.1/udp/22445/quic-v1 }
2025-08-26T09:30:21.079963176Z Swarm event: NewExternalAddrOfPeer { peer_id: PeerId("12D3KooWQC9tPzj2ShLn39RFHS5SGbvbP2pEd7bJ61kSW2LwxGSB"), address: /ip4/10.6.4.8/udp/22445/quic-v1 }
2025-08-26T09:30:21.079999825Z Swarm event: NewExternalAddrCandidate { address: /ip4/162.19.121.18/udp/65224/quic-v1 }
2025-08-26T09:30:21.604794161Z Swarm event: Dialing { peer_id: Some(PeerId("12D3KooWQMT5EsPowQHoPaDmCxDnUgnkFGu16DFYgp6xzpj5e3pS")), connection_id: ConnectionId(3) }
2025-08-26T09:30:21.604832092Z Swarm event: Dialing { peer_id: Some(PeerId("12D3KooWNJUY4VMSmbD8xPwhJn19CB9hHQjJmEhXcEZBWsYuf6DB")), connection_id: ConnectionId(4) }
2025-08-26T09:30:21.606099658Z Swarm event: Dialing { peer_id: Some(PeerId("12D3KooWEJmVk686ksUCCr6dEKTX6ezSkMZqjLy1ZWasArNM1nbk")), connection_id: ConnectionId(5) }
2025-08-26T09:30:21.630548510Z Swarm event: ConnectionEstablished { peer_id: PeerId("12D3KooWNJUY4VMSmbD8xPwhJn19CB9hHQjJmEhXcEZBWsYuf6DB"), connection_id: ConnectionId(4), endpoint: Dialer { address: /ip4/147.78.211.212/udp/12345/quic-v1/p2p/12D3KooWNJUY4VMSmbD8xPwhJn19CB9hHQjJmEhXcEZBWsYuf6DB, role_override: Dialer, port_use: Reuse }, num_established: 1, concurrent_dial_errors: Some([]), established_in: 25.608654ms }
2025-08-26T09:30:21.635188594Z Swarm event: ConnectionEstablished { peer_id: PeerId("12D3KooWQMT5EsPowQHoPaDmCxDnUgnkFGu16DFYgp6xzpj5e3pS"), connection_id: ConnectionId(3), endpoint: Dialer { address: /ip4/95.216.66.187/udp/12345/quic-v1/p2p/12D3KooWQMT5EsPowQHoPaDmCxDnUgnkFGu16DFYgp6xzpj5e3pS, role_override: Dialer, port_use: Reuse }, num_established: 1, concurrent_dial_errors: Some([]), established_in: 30.332336ms }
2025-08-26T09:30:21.635782011Z Swarm event: ConnectionEstablished { peer_id: PeerId("12D3KooWEJmVk686ksUCCr6dEKTX6ezSkMZqjLy1ZWasArNM1nbk"), connection_id: ConnectionId(5), endpoint: Dialer { address: /ip4/65.108.121.153/udp/12345/quic-v1/p2p/12D3KooWEJmVk686ksUCCr6dEKTX6ezSkMZqjLy1ZWasArNM1nbk, role_override: Dialer, port_use: Reuse }, num_established: 1, concurrent_dial_errors: Some([]), established_in: 29.62815ms }
2025-08-26T09:30:21.656992166Z Swarm event: NewExternalAddrOfPeer { peer_id: PeerId("12D3KooWNJUY4VMSmbD8xPwhJn19CB9hHQjJmEhXcEZBWsYuf6DB"), address: /ip4/147.78.211.212/udp/12345/quic-v1/p2p/12D3KooWNJUY4VMSmbD8xPwhJn19CB9hHQjJmEhXcEZBWsYuf6DB }
2025-08-26T09:30:21.657036680Z Swarm event: NewExternalAddrOfPeer { peer_id: PeerId("12D3KooWNJUY4VMSmbD8xPwhJn19CB9hHQjJmEhXcEZBWsYuf6DB"), address: /ip4/127.0.0.1/udp/12345/quic-v1 }
2025-08-26T09:30:21.657065514Z Swarm event: NewExternalAddrOfPeer { peer_id: PeerId("12D3KooWNJUY4VMSmbD8xPwhJn19CB9hHQjJmEhXcEZBWsYuf6DB"), address: /ip4/10.171.2.22/udp/12345/quic-v1 }
2025-08-26T09:30:21.657101051Z Swarm event: NewExternalAddrCandidate { address: /ip4/162.19.121.18/udp/13862/quic-v1 }
2025-08-26T09:30:21.665580342Z Swarm event: NewExternalAddrOfPeer { peer_id: PeerId("12D3KooWEJmVk686ksUCCr6dEKTX6ezSkMZqjLy1ZWasArNM1nbk"), address: /ip4/65.108.121.153/udp/12345/quic-v1 }
2025-08-26T09:30:21.665602444Z Swarm event: NewExternalAddrOfPeer { peer_id: PeerId("12D3KooWEJmVk686ksUCCr6dEKTX6ezSkMZqjLy1ZWasArNM1nbk"), address: /ip4/172.18.0.2/udp/12345/quic-v1 }
2025-08-26T09:30:21.665636097Z Swarm event: NewExternalAddrOfPeer { peer_id: PeerId("12D3KooWEJmVk686ksUCCr6dEKTX6ezSkMZqjLy1ZWasArNM1nbk"), address: /ip4/127.0.0.1/udp/12345/quic-v1 }
2025-08-26T09:30:21.665649602Z Swarm event: NewExternalAddrCandidate { address: /ip4/162.19.121.18/udp/26848/quic-v1 }
2025-08-26T09:30:21.668145350Z Swarm event: NewExternalAddrOfPeer { peer_id: PeerId("12D3KooWQMT5EsPowQHoPaDmCxDnUgnkFGu16DFYgp6xzpj5e3pS"), address: /ip4/95.216.66.187/udp/12345/quic-v1 }
2025-08-26T09:30:21.668190996Z Swarm event: NewExternalAddrOfPeer { peer_id: PeerId("12D3KooWQMT5EsPowQHoPaDmCxDnUgnkFGu16DFYgp6xzpj5e3pS"), address: /ip4/172.23.0.2/udp/12345/quic-v1 }
2025-08-26T09:30:21.668231472Z Swarm event: NewExternalAddrOfPeer { peer_id: PeerId("12D3KooWQMT5EsPowQHoPaDmCxDnUgnkFGu16DFYgp6xzpj5e3pS"), address: /ip4/127.0.0.1/udp/12345/quic-v1 }
2025-08-26T09:30:21.668269514Z Swarm event: NewExternalAddrCandidate { address: /ip4/162.19.121.18/udp/40996/quic-v1 }
2025-08-26T09:30:21.681174595Z Swarm event: Dialing { peer_id: Some(PeerId("12D3KooWHKBBGyYU83Jx3eCPCTPbysPe7e6bbVhYtvvHsP6QELfD")), connection_id: ConnectionId(6) }
2025-08-26T09:30:21.694287208Z Swarm event: Dialing { peer_id: Some(PeerId("12D3KooWM33BK2xQ5XYcdV8gduPXZJHCjkYQmcjZnSbJBkYxuCW2")), connection_id: ConnectionId(7) }
2025-08-26T09:30:21.697273389Z Swarm event: Dialing { peer_id: Some(PeerId("12D3KooWHKvqRmBizZPwyznsHE7yRaQK1YK9qsDQszGruxK5EXoG")), connection_id: ConnectionId(8) }
2025-08-26T09:30:21.697334374Z Swarm event: Dialing { peer_id: Some(PeerId("12D3KooW9yQws9oxjj6aAAKov8zb69ZVj5UEBzFh6sD4srTNfQFb")), connection_id: ConnectionId(9) }
2025-08-26T09:30:21.697396311Z Swarm event: Dialing { peer_id: Some(PeerId("12D3KooWQvLUZvHZaJow5VorSsGUoCFMyrdCWRJGgEJiy9m1qSnh")), connection_id: ConnectionId(10) }
2025-08-26T09:30:21.697458698Z Swarm event: Dialing { peer_id: Some(PeerId("12D3KooWEYbv2PZnrjc2dWMwiH7zRP3AWCZLHQETNRtAUbBeh7rt")), connection_id: ConnectionId(11) }
2025-08-26T09:30:21.697518190Z Swarm event: Dialing { peer_id: Some(PeerId("12D3KooWDYkXwAXTcnbTk9KKsBoNEoiZfEPbM9pAD1EJBHxA54Yg")), connection_id: ConnectionId(12) }
2025-08-26T09:30:21.697571871Z Swarm event: Dialing { peer_id: Some(PeerId("12D3KooWM5ca

This same root cause must be fixed before merging.
REVIEW_EOF
