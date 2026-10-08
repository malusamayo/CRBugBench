#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `x-pack/plugin/esql/src/main/java/org/elasticsearch/xpack/esql/parser/LogicalPlanBuilder.java`:

This pull request introduces the defect later reported as "ES|QL: empty patterns in DISSECT command return empty attribute name and null value". The
problem a user observed, and its root cause:

```
ROW a="b c d"
| DISSECT a "%{b} %{} %{d}"
```
returns

```
       a       |       b       |               |       d       
---------------+---------------+---------------+---------------
b c d          |b              |null           |d 
```

it should ignore the empty pattern instead, and only return `a, b, d`

This same root cause must be fixed before merging.
REVIEW_EOF
