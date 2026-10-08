#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/test/java/io/reactivex/rxjava3/schedulers/IoScheduledReleaseTest.java` (around line 28): This will not work because the classes have been already initialized. For a workaround, change

`private static final boolean USE_SCHEDULED_RELEASE;`

to

`static boolean USE_SCHEDULED_RELEASE;`

move this `IoScheduledReleaseTest` to `package io.reactivex.rxjava3.internal.schedulers;`,

then:

```java
boolean save = IoScheduler.USE_SCHEDULED_RELEASE;
IoScheduler.USE_SCHEDULED_RELEASE = true;
try {
  // ...
} finally {
    IoScheduler.USE_SCHEDULED_RELEASE = save;
}
```
REVIEW_EOF
