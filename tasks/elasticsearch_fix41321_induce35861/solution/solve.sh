#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `buildSrc/src/main/java/org/elasticsearch/gradle/precommit/TestingConventionsTasks.java`:

This pull request introduces the defect later reported as ""precommit" on SQL security "with-ssl" and "without-ssl" projects fails after a "gradle clean"". The
problem a user observed, and its root cause:

To reproduce this:
1. `gradlew clean`
2. `gradlew :x-pack:plugin:sql:qa:security:without-ssl:precommit --parallel`
or
`gradlew :x-pack:plugin:sql:qa:security:with-ssl:precommit --parallel`

This will fail with 

```
> Task :x-pack:plugin:sql:qa:security:without-ssl:testingConventions FAILED
Expected at least one test class included in task :x-pack:plugin:sql:qa:security:without-ssl:integTestRunner, but found none.

FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':x-pack:plugin:sql:qa:security:without-ssl:testingConventions'.
> Testing conventions are not honored
```

Digging into this a bit, it seems the PR that fixed https://github.com/elastic/elasticsearch/issues/40550 seems to be the one that introduced the behavior above.

CC @mark-vieira @atorok

This same root cause must be fixed before merging.
REVIEW_EOF
