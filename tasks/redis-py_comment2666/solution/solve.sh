#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `tests/test_asyncio/test_cwe_404.py` (around line 13): The walrus operator was only introduced in Python 3.8 (see [PEP 572](https://peps.python.org/pep-0572/)).

Since this library supports Python 3.7 as well, this line should be changed to:

```suggestion
    while True:
        data = await reader.read(1000)
        if not data:
            break
```
REVIEW_EOF
