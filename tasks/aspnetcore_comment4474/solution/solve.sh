#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `.azure/pipelines/signalr-daily-tests.yml` (around line 7): This isn't in the right location. This needs to be under "jobs > parameters"

```diff
   parameters:
     buildDirectory: src/SignalR
     buildArgs: "/p:DailyTests=true /p:SauceUser='$(asplab-sauce-labs-username)' /p:SauceKey='$(asplab-sauce-labs-access-key)'"
     agentOs: Windows
     jobName: SignalRDailyTests
     jobDisplayName: "SignalR Daily Tests"
+    artifacts:
+      publish: true
+      path: 'src/SignalR/artifacts/'
```
REVIEW_EOF
