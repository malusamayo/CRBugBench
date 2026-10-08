#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `crates/bevy_asset/src/processor/mod.rs` (around line 532): Based on [the description of `&&`](https://doc.rust-lang.org/reference/expressions/operator-expr.html#lazy-boolean-operators), it actually serves no purpose beyond a normal `&` in this instance, therefore the `&=` operator can be used instead, simplifying the expression without any change. This will also avoid the unintended consequence of not evaluating `get_asset_paths` if the order of the `&&` operands were reversed.

More importantly, I think it's actually _wrong_. I believe the intent was to use logical OR, since (I believe) this `get_asset_paths` function is supposed to return `true` if _any_ sub-folder contains a file, but right now it will only do so if _every_ folder does, which doesn't seem right to me.

I believe this is why line 536 has a comment suppressing the error likely being returned by `remove_empty_directory`.

So, with _all_ that context, here's my suggestion:

```suggestion
                    contains_files |= Box::pin(get_asset_paths(
                        reader,
                        clean_empty_folders_writer,
                        child_path,
                        paths,
                    ))
                    .await?;
```
REVIEW_EOF
