#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `pandas/core/config_init.py`:

This pull request introduces the defect later reported as "BUG display.max_colwidth do not accept -1 for unlimited width". The
problem a user observed, and its root cause:

#### Code Sample, a copy-pastable example if possible

```python
import pandas as pd
pd.set_option("display.max_colwidth", -1)
```
#### Problem description

There is a regression with `"display.max_colwidth"`. In the past, it was only accepting integer. The way to no limit the size was to pass `-1`. In pandas 1,0, this option becomes more consistent and not limiting the width should be set with `None`. However, the support for negative integer was removed.

Thus, one would need to either set to `-1` or `None` depending on the pandas version. It would be best to support both options. Potentially, support for negative integer could be removed with a deprecation cycle.

This same root cause must be fixed before merging.
REVIEW_EOF
