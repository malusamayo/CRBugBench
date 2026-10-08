#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `homeassistant/components/mqtt/strings.json` (around line 224): ```suggestion
            "name": "The name of the entity. Leave empty to set it to `None` to [mark it as main feature of the MQTT device]({naming_entities_url}).",
```
REVIEW_EOF
