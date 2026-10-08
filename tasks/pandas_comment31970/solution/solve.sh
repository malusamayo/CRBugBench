#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `pandas/core/indexing.py` (around line 93): why's this changing? adding the f seems to give me a blank docstring on my machine, Windows

```
>>> help(pd.core.indexing.IndexingMixin.iloc)
Help on property:


```
whereas without the f prefix i get the docstring

```
>>> help(pd.core.indexing.IndexingMixin.iloc)
Help on property:

    Purely integer-location based indexing for selection by position.

    ``.iloc[]`` is primarily integer position based (from ``0`` to
...
```
REVIEW_EOF
