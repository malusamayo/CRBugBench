#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `modules/openapi-generator/src/main/java/org/openapitools/codegen/languages/PostmanCollectionCodegen.java`:

This pull request introduces the defect later reported as "[BUG][POSTMAN] Path parament syntax is incorrect". The
problem a user observed, and its root cause:

#### Bug Report Checklist

- [x] Have you provided a full/minimal spec to reproduce the issue?
- [x] Have you validated the input using an OpenAPI validator ([example](https://apidevtools.org/swagger-parser/online/))?
- [x] Have you [tested with the latest master](https://github.com/OpenAPITools/openapi-generator/wiki/FAQ#how-to-test-with-the-latest-master-of-openapi-generator) to confirm the issue still exists?
- [x] Have you searched for related issues/PRs?
- [x] What's the actual output vs expected output?
- [ ] [Optional] Sponsorship to speed up the bug fix or feature request ([example](https://github.com/OpenAPITools/openapi-generator/issues/6178))

##### Description

When generating a Postman collection the OpenAPI endpoint URL`{{baseUrl}}/users/{id}` should be converted to `{{baseUrl}}/users/:id`, following the Postman schema.
This approach makes sure it is possible to set the path parameter value in Postman without modifying the original URL.

##### openapi-generator version

7.1.0-SNAPSHOT

This same root cause must be fixed before merging.
REVIEW_EOF
