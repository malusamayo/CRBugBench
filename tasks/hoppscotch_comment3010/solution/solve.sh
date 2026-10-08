#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `packages/hoppscotch-common/src/components/collections/SaveRequest.vue` (around line 134): Here since the ref `requestName` is initialized when the component is rendered first. it won't be updated if there is an update to the currentActiveTab.value, for eg: try renaming the request, and see the value in the save request model.

you can add a watcher on the restRequestName that will update the ref incase the name changes from the tabs side. 

```javascript
watch(restRequestName, (newValue) => {
  requestName.value = newValue
})
```
REVIEW_EOF
