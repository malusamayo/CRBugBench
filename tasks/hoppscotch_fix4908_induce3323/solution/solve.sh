#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/hoppscotch-common/src/helpers/import-export/import/openapi.ts`:

This pull request introduces the defect later reported as "[bug]: unresolved base URL in request endpoints during OpenAPI imports". The
problem a user observed, and its root cause:

### Is there an existing issue for this?

- [x] I have searched the existing issues

### Current behavior

When I import Open API it create request `undefined/api/v2/list` from `/api/v2/list`. so I need manually edit each request. It should use environment variable for base path instead of undefined string.

### Steps to reproduce

1.     Import/Export
2.     Import from OpenAPI
3.     Import from file
4.     Choose file
5.     Import

Use for example Grafana API
[grafana_api-merged.json](https://github.com/user-attachments/files/19110003/grafana_api-merged.json)


### Environment

Production

### Version

Cloud

This same root cause must be fixed before merging.
REVIEW_EOF
