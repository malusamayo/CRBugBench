#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `benchmark_v2/framework/benchmark_config.py`:

This pull request introduces the defect later reported as "benchmarker_V2: sdpa_backend handling and level 2 config issue". The
problem a user observed, and its root cause:

### System Info

Hi @McPatate, @remi-or,

I noticed a few things in `BenchmarkConfig`:

1. In `check_validity`, for `continuous_batching` you check `sdpa_backend is not None` and then set it to `"math"`, but earlier it’s already set to `"flash_attention"` if None. The warning says it should be None, but it’s set to `"math"`.

2. Level 3/4 in `get_config_by_level` generates all configs but ignores `"paged|sdpa"`, which will be included in level 2.

Thanks!

This same root cause must be fixed before merging.
REVIEW_EOF
