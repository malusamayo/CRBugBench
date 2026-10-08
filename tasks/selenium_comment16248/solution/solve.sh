#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `py/selenium/webdriver/remote/webdriver.py` (around line 1216): ```suggestion
            ws_url,
            self.command_executor.client_config.websocket_timeout,
            self.command_executor.client_config.websocket_interval,
```

All BiDi tests are failing because of this.
REVIEW_EOF
