#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `testsuite/integration-arquillian/tests/other/console/src/test/java/org/keycloak/testsuite/console/realm/LoginSettingsTest.java` (around line 242): _UserRepresentation_ is basically DTO, but the user is not created on the server.
Please import this:
```
import static org.junit.Assert.assertNotNull;
import static org.keycloak.testsuite.admin.ApiUtil.createUserWithAdminClient;
```
Create user on the server.
```suggestion
String id = createUserWithAdminClient(testRealmResource(), utf8TestUser);
assertNotNull(id);
```
REVIEW_EOF
