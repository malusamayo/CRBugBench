#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `meilisearch-auth/src/key.rs`:

This pull request introduces the defect later reported as "The field `description` to `POST` a `Key` cannot be set to null.". The
problem a user observed, and its root cause:

**Describe the bug**
The field `description` to `POST` a `Key` cannot be set to null.

**To Reproduce**
```json
{
    "description": null,
    "actions": [
        "documents.add"
    ],
    "indexes": ["*"],
    "expiresAt": "2022-11-13T00:00:00"
}
```

**Expected behavior**
Following the error code [`invalid_api_key_description`](https://docs.meilisearch.com/reference/api/error_codes.html#invalid-api-key-description) the API should accept a string or null as a value.

**Actual behavior**
```json
{
	"message": "description field value `null` is invalid. It should be a string or specified as a null value.",
	"code": "invalid_api_key_description",
	"type": "invalid_request",
	"link": "https://docs.meilisearch.com/errors#invalid_api_key_description"
}
```

**MeiliSearch version:** v0.25.2

**Additional context**
Post a new key without `description` field works:
```json
{
    "actions": [
        "documents.add"
    ],
    "indexes": ["*"],
    "expiresAt": "2022-11-13T00:00:00"
}
```
Response:
```
{
	"description": null,
	"key": "TJB4JSBJ749cd25bc238a3eafb7d8cea1e6710676d77a6e4637f512fdfae63f1c2d87cf7",
	"actions": [
		"documents.add"
	],
	"indexes": [
		"*"
	],
	"expiresAt": "2022-11-13T00:00:00Z",
	"createdAt": "2022-01-26T12:44:52Z",
	"updatedAt": "2022-01-26T12:44:52Z"
}
```

This same root cause must be fixed before merging.
REVIEW_EOF
