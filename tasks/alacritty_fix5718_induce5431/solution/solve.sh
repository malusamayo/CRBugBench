#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `alacritty/src/cli.rs`:

This pull request introduces the defect later reported as "Some tests fail after trying to parse libtest arguments". The
problem a user observed, and its root cause:

Since https://github.com/alacritty/alacritty/commit/62a1fad524ebdf0592bb37aed76c2caac29a7f47, the three tests `cli::tests::dynamic_title_*` fail when run with `cargo test -- --test-threads=$n`:

```
test cli::tests::dynamic_title_ignoring_options_by_default ... error: Found argument '--test-threads' which wasn't expected, or isn't valid in this context
```

The current workaround is to also pass `--skip=dynamic_title`.

This same root cause must be fixed before merging.
REVIEW_EOF
