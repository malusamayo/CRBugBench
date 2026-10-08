#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `rest/admin-v2/services/src/main/java/org/keycloak/rest/admin/api/DefaultAdminApi.java` (around line 20): ```suggestion
        RealmModel realm = session.realms().getRealmByName(realmName);
        if (realm == null) throw new NotFoundException("Realm not found.");
```
REVIEW_EOF
