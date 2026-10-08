#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `meilisearch-http/src/routes/indexes/documents.rs`:

This pull request introduces the defect later reported as "Incorrect error message for content-type error". The
problem a user observed, and its root cause:

**Describe the bug**
When an invalid content-type header is sent the the error message that is returned says: `Error message: The Content-Type "applicaiton/csv" is invalid. Accepted values for the Content-Type header are: "application/json", "application/x-ndjson", "application/csv".`, however for `csv` files it should be `text/csv` instead of `applicaiton/csv`.

**To Reproduce**
Send documents to either the add documents or update documents routes with and invalid content-type, such as `Content-Type: application/csv`

**Expected behavior**
The error message should state ``Error message: The Content-Type "applicaiton/csv" is invalid. Accepted values for the Content-Type header are: "application/json", "application/x-ndjson", "text/csv".``

**MeiliSearch version:**
v0.23.1

This same root cause must be fixed before merging.
REVIEW_EOF
