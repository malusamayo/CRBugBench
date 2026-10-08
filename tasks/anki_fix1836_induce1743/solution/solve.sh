#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `rslib/src/import_export/gather.rs`:

This pull request introduces the defect later reported as "legacy apkgs with subdeck root fail to import". The
problem a user observed, and its root cause:

To repro:

- create a card and put it in a foo::bar deck, then export that deck using the legacy exporter
- attempt to import it using the new importer, and be told you should run "check database" :-)

Because this is not such an uncommon case, we should ideally handle this instead of throwing an error. Maybe a low-effort solution would be, when this error is encountered, to run the part of the DB check that adds missing parents. I think you mentioned something like this in the past Rumo.

This same root cause must be fixed before merging.
REVIEW_EOF
