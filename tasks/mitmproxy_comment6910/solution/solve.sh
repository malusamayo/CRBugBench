#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `web/gen/options_js.py` (around line 64): windows tests are failing because of [this](https://stackoverflow.com/questions/47384652/python-write-replaces-n-with-r-n-in-windows) issue, we should specify the default newline character as `\n`. One way to do this could be:
```suggestion
    filehandle = filename.open(mode='w', newline='\n')
    filehandle.write(asyncio.run(make()))
```
This would have to be done for `state_js.py` and `tflow_js.py` as well
REVIEW_EOF
