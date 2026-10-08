#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/model/channel/message.rs` (around line 1215): Need to wrap this in `enum_number! {}` to deserialize the value. Also, docs don't specify a default value, so probably best to drop that. Docs don't mention the possibility of new variants, but might not hurt to add `non_exhaustive` anyway.

```suggestion
enum_number! {
    /// Base theme for the shared client theme.
    ///
    /// [Discord docs](https://docs.discord.com/developers/resources/message#base-theme-types).
    #[derive(Clone, Copy, Debug, Eq, Hash, Ord, PartialEq, PartialOrd, Deserialize, Serialize)]
    #[cfg_attr(feature = "typesize", derive(typesize::derive::TypeSize))]
    #[non_exhaustive]
    pub enum BaseTheme {
        Dark = 1,
        Light = 2,
        Darker = 3,
        Midnight = 4,
        _ => Unknown(u8),
    }
}
```
REVIEW_EOF
