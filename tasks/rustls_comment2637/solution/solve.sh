#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `rustls/src/msgs/codec.rs` (around line 279): Sorry, this one should be `ListLength::U24`. This line is the second half of this definition in TLS1.2:

```
      opaque ASN.1Cert<1..2^24-1>;

      struct {
          ASN.1Cert certificate_list<0..2^24-1>;
      } Certificate;
```

In other words, the list of certificates can be empty, but individual certificates cannot.

The `impl Codec for CertificateDer...` part above, is the first. So actually that needs _not_ to use `Self::SIZE_LEN` (which is the size prefix for a vector of `CertificateDer`s, and that can be empty)  but instead a `ListLength::NonZeroU24 { ... }`
REVIEW_EOF
