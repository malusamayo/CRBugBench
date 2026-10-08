#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `services/src/main/java/org/keycloak/protocol/oidc/utils/OIDCRedirectUriBuilder.java` (around line 208): I think that in case that clientSession is not null, the issuer should be still kept to `clientSession.getNote(OIDCLoginProtocol.ISSUER);` . The issuer based on `Urls.realmIssuer(session.getContext().getUri().getBaseUri(), realm.getName())` should be used just in case that clientSession is null.

I believe this is the reason of the test failures, which look like regression of this PR (EG. DefaultHostnameTest).
REVIEW_EOF
