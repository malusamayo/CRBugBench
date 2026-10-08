#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `misc/connection-limits/src/lib.rs`:

This pull request introduces the defect later reported as "Failed outbound connections and connection limits". The
problem a user observed, and its root cause:

<!-- Thank you for filing a bug report! -->

<!-- For security related issues please file a private security vulnerability report at https://github.com/libp2p/rust-libp2p/security/advisories/new or reach out to security@libp2p.io. Please do not file a public issue on GitHub. -->

## Summary

This may be a pre-mature issue as I've not yet found the actual source of the issue. 

Lighthouse is upgrading to libp2p v0.52. We cannot establish new connections. What appears to be happening is:
1. We attempt to dial a multitude of peers. 
2. Many of these fail (they can be offline, or not accepting connections. We often see transport failures (I believe this is normal). For example: ` Failed to negotiate transport protocol(s): [(/ip4/x.x.x.x/tcp/9000: : Multistream select failed: Multistream select failed: Protocol error: I/O error: Connection reset by peer (os error 104): I/O error: Connection reset by peer (os error 104): Connection reset by peer (os error 104))]`
3.  Lighthouse has an outbound pending connection limit of 16. After 16 failed dial attempts, all future attempts fail with:
`Denied { cause: ConnectionDenied { inner: Exceeded { limit: 16, kind: PendingOutgoing } } }`

Initial suspicion is that these failures are not reducing the outbound connection count. I'm posting this issue before I check the latest code, as someone may see the problem faster than me.

This same root cause must be fixed before merging.
REVIEW_EOF
