#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `crates/milli/src/update/new/words_prefix_docids.rs` (around line 325): The source database is serialized as `word, 0, position -> docids`, which means it will be ordered as below:
```
he, 0, 0 -> [docids]
he, 0, 1 -> [docids]
he, 0, 2 -> [docids]
hell, 0, 0 -> [docids]
hell, 0, 1 -> [docids]
hell, 0, 2 -> [docids]
hello, 0, 0 -> [docids]
hello, 0, 1 -> [docids]
hello, 0, 2 -> [docids]
heritage, 0, 0 -> [docids]
heritage, 0, 1 -> [docids]
heritage, 0, 2 -> [docids]
```

Meaning that for the prefix `h`, it would create more than one `PrefixIntegerEntry` per position:

```rust
PrefixIntegerEntry { prefix: "h", pos: 0, .. } // he, 0, 0
PrefixIntegerEntry { prefix: "h", pos: 1, .. } // he, 0, 1 : because we changed position
PrefixIntegerEntry { prefix: "h", pos: 2, .. } // he, 0, 2 : because we changed position
PrefixIntegerEntry { prefix: "h", pos: 0, .. } // hell, 0, 0 : we come back to position 0 and we push the same PrefixIntegerEntry as the first one but with different docids.
...
```

then when writing into the database, we iterate over the indexes `for PrefixIntegerEntry { prefix, pos, serialized_length } in index` and override the value.

I think the persisted value for each prefixes will only contain the  `docids` of the last word starting with the prefix for each position.
In our example, we would only have the `heritage` docids for the `h` prefix.

Am I right, or am I missing something? 🤔
REVIEW_EOF
