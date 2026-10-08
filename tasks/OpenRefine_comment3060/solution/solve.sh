#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `extensions/wikidata/src/org/openrefine/wikidata/qa/SchemaPropertyFetcher.java` (around line 36): Here, you are adding new snaks to the list of qualifiers of the expression (`statementExpr.getQualifiers()`). This will modify the list of qualifiers in the schema. This is my fault, I should have wrapped the returned lists with `Collections.unmodifiableList()` in getters. Opening an issue about it: #3064.

On your side, the solution should be to create a new list: `new ArrayList<>(statementExpr.getQualifiers())` instead of just `statementExpr.getQualifiers()`.
REVIEW_EOF
