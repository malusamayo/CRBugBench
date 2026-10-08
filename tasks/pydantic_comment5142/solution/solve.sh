#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `pydantic/_internal/_generate_schema.py` (around line 302): Do you know if pre-3.11 (or at least, pre-`__required_keys__`) if you could achieve more nuanced logic as a function of base classes? I'm thinking the answer is yes. I defer to you/Samuel what we should do before `__required_keys__` was available, but if we leave the logic like this, it is probably worth noting in this comment that technically this might not perfectly match the defined intent.

What I mean is:
```python
class MyTotalTypedDict(TypedDict):
    x: int

class MyLessTotalTypedDict(MyTotalTypedDict, total=False):
    y: int
```
Even in versions of python without `__required_keys__` I think `x` might be required and `y` not required.
REVIEW_EOF
