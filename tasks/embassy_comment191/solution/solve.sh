#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `embassy-stm32/src/exti.rs` (around line 239): This macro doesn't work, it only enables the first irq because the rest is emitted in another nested `init` fn: https://play.rust-lang.org/?version=stable&mode=debug&edition=2018&gist=a64213eb9a462f7ed9f00ff1a310d4f2

using macro repetition directly is easier:

```rust


macro_rules! impl_exti_init {
    ($($e:ident),+) => {
        /// safety: must be called only once
        pub(crate) unsafe fn init() {
            $(
                crate::interrupt::$e::steal().enable();
            )+
        }
    };
}
REVIEW_EOF
