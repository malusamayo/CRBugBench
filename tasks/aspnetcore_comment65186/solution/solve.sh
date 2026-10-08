#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/DataProtection/DataProtection/src/SP800_108/ManagedSP800_108_CTR_HMACSHA512.cs` (around line 48): ```C#
if (kdk.Length < FipsMinimumKeyLengthInBytes)
{
    Span<byte> zeroExtended = stackalloc byte[FipsMinimumKeyLengthInBytes];
    zeroExtend.Clear();
    kdk.CopyTo(zeroExtend);
    return DeriveKeys(zeroExtend, ...);
}
```

HMAC keys shorter than the algorithm's (internal) block size are zero-appended, so just doing that up front will give the same answer.

We clearly do that for the instance method.  I don't remember if we explicitly decided not to do it for the statics, or if it's just that it used to not be enforced by OSSL in their "FIPS mode" and now it is.
REVIEW_EOF
