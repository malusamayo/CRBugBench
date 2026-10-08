#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `meilisearch-auth/src/error.rs`:

This pull request introduces the defect later reported as "Wrong variant returned for `invalid_api_key_indexes` error when creating an API key.". The
problem a user observed, and its root cause:

> Sending a value that is not a valid index (e.g. regarding the index uid format) in the indexes field returns an [invalid_api_key_indexes](https://github.com/meilisearch/meilisearch/issues/0061-error-format-and-definitions.md#invalid_api_key_indexes) with a variant error message. See "Sending an invalid index uid format in indexes field" variant.

It should have been solved by https://github.com/meilisearch/meilisearch/issues/2158, but I did not get the new variant testing on the latest version.

```json
{
    "message": "`indexes` field value `[\"invalid index # / \\name with spaces\"]` is invalid. It should be an array of string representing index names.",
    "code": "invalid_api_key_indexes",
    "type": "invalid_request",
    "link": "https://docs.meilisearch.com/errors#invalid_api_key_indexes"
}
```

while I should receive

```json
{
    "message": "` [\"invalid index # / \\name with spaces\"]` is not a valid index uid. Index uid can be an integer or a string containing only alphanumeric characters, hyphens (-) and underscores (_).",
    "code": "invalid_api_key_indexes",
    "type": "invalid_request",
    "link": "https://docs.meilisearch.com/errors#invalid_api_key_indexes"
}
```

Relates to that catch-up specification https://github.com/meilisearch/specifications/pull/181 (The original one was never merged 🤔 So it makes me doubt if it was solved)

This same root cause must be fixed before merging.
REVIEW_EOF
