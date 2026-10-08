#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `packages/hoppscotch-common/src/helpers/import-export/import/openapi.ts`:

This pull request introduces the defect later reported as "[bug]: OpenAPI import shows all response codes as 200". The
problem a user observed, and its root cause:

### Is there an existing issue for this?

- [x] I have searched existing issues and this bug hasn't been reported yet

### Current behavior

I import a collection from OpenAPI, which contains the following responses:

```json
        "responses" : {
          "200" : {
            "description" : "Das Bild"
          },
          "400" : {
            "description" : "Die Parameter fehlen oder sind falsch"
          },
          "404" : {
            "description" : "Das Dokument oder dessen Inhalt konnte aufgrund der Dokument-Adresse nicht gefunden werden"
          },
          "500" : {
            "description" : "Das Bild konnte nicht konvertiert werden"
          }
        }
```

When it's imported, all response codes are shown as 200.

### Steps to reproduce

1. Go to 'Personal Workspace > Collections'
2. Click on 'Import / Export'
3. Click on 'Import from OpenAPI' and 'Import from URL'
4. Choose an URL that contains several responses for an endpoint
5. Check how they are shown in the collection

### Logs and Screenshots

![Image](https://github.com/user-attachments/assets/41a1526d-bd8c-4992-9a5d-1a185df067da)

### Environment

Production

### Hoppscotch Version

Self-hosted

### Interceptor

Not Applicable - Issue not related to network requests

### Browsers Affected

_No response_

### Operating System

None

### Additional Information

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
