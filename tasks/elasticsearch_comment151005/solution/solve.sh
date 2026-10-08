#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `x-pack/plugin/esql/src/main/java/org/elasticsearch/xpack/esql/expression/function/fulltext/Match.java` (around line 492): This assertion only runs when the JVM is started with enable assertions flag (-ea). The production JVMs don't run with -ea.

If queryObject ends up not being a Long, the assert is going to be skipped in production; and the cast in the next line will through a ClassCastException.

Could replace it with a check:
 ```java
if (queryObject instanceof Long queryLong == false) {
throw EsqlIllegalArgumentException.illegalDataType(field.dataType());
  }
```

what do you think?
REVIEW_EOF
