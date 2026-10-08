#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `test/runner/lib/cloud/vcenter.py` (around line 251): Environment variables won't be available when delegation such as `--docker` is used. To guarantee settings are available after delegation, use `_set_cloud_config` to preserve them. Example:

https://github.com/ansible/ansible/blob/690037876648e515fdf1e9d6dd82c760b9bd0f72/test/runner/lib/cloud/vcenter.py#L135

To retrieve values use `_get_cloud_config`. Example:

https://github.com/ansible/ansible/blob/690037876648e515fdf1e9d6dd82c760b9bd0f72/test/runner/lib/cloud/vcenter.py#L153
REVIEW_EOF
