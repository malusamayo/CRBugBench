#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `pydantic/main.py` (around line 685): This will break if you have a second field in your model e.g.
```python
    class Model(BaseModel):
        baz: Literal[FooEnum.foo]
        boo: str
```
It will run `v.value` on `boo`
(And btw you should use another variable instead of a local `v`, which is confusing with the other one)
REVIEW_EOF
