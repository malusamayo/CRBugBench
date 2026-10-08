#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `meilisearch-lib/src/index_controller/index_resolver/mod.rs`:

This pull request introduces the defect later reported as "Too many open files error". The
problem a user observed, and its root cause:

When running the SDK tests, we get "too many open files" error

Steps

- Run MeiliSearch with a master key:
```
cargo run --release -- --master-key=masterKey
```

- Clone the meilisearch-js repo and run the tests
```
git clone git@github.com:meilisearch/meilisearch-js.git
cd meilisearch-js
yarn
yarn test
```

On macOS
The bug was not present in v0.22.0

This same root cause must be fixed before merging.
REVIEW_EOF
