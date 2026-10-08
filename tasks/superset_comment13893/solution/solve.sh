#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `superset/queries/saved_queries/commands/importers/v1/__init__.py` (around line 74): A saved query has a many-to-one relationship to database; there are no datasources involved. What you need to do here is update the [`db_id` attribute of the saved query model](https://github.com/apache/superset/blob/master/superset/models/sql_lab.py#L179) and point it to the imported/existing database:

```suggestion
                config["db_id"] = database_ids[config["database_uuid"]]
```
REVIEW_EOF
