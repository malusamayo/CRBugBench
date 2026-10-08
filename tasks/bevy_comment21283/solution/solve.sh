#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `crates/bevy_asset/src/io/wasm.rs` (around line 59): Using `use<'_>` elides the lifetime to match that of `&self`, but here self is a stack variable which makes borrow checking fail. Instead you need an empty `use<>`.

```suggestion
    ) -> Result<impl Reader + use<>, AssetReaderError> {
```
REVIEW_EOF
