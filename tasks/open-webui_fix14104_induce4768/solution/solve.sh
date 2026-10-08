#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `backend/open_webui/internal/wrappers.py`:

This pull request introduces the defect later reported as "DATABASE_URL cannot contain @ sign in username". The
problem a user observed, and its root cause:

# Bug Report

## Installation Method

kubernetes deployment

## Environment

- **Open WebUI Version:** v0.5.14

- **Operating System:** linux

**Confirmation:**

- [*] I have read and followed all the instructions provided in the README.md.
- [*] I am on the latest version of both Open WebUI and Ollama.
- [*] I have provided the exact steps to reproduce the bug in the "Steps to Reproduce" section below.

## Expected Behavior:

When specifying an external database using the DATABASE_URL, the username might contain an @ sign, just like the password might contain special characters.  The @ sign is stored as %40 in the DATABASE_URL value.  OpenWebUI should properly decode this URL and turn %40 back into @ before sending the username to the database.

I know the lack of password in my example might cause confusion.  But this is completely normal in a Cloud environment.
Access is defined in Terraform and controlled using IAM service accounts which contain @ signs.  GCP's CloudSQL supports adding the service account as a database user where no password is necessary.  We use this extensively in our cloud projects.  It's clear from the code that the password (or lack of) is unrelated.

Example of a URL using a GCP service account username:
`"postgresql://open-webui-svc%40myproject.iam@localhost/owui_gen"`

## Actual Behavior:

The username is not properly parsed by the peewee library.  The escaped username (open-webui-svc%40myproject.iam) is sent to postgres and postgres returns an error mentioning the escaped username:

`Failed to initialize the database connection: connection to server at "localhost" (127.0.0.1), port 5432 failed: FATAL:  password authentication failed for user "open-webui-svc%40myproject.iam"`

## Description

**Bug Summary:**
A Database URL might contain escaped (URL-encoded) characters in the username.  Open-WebUI should decode these correctly.

## Reproduction Details

**Steps to Reproduce:**
Set up a postgres database.  
Create a user with an @ sign in the name.  
Set DATABASE_URL to point to your database with the username properly encoded.

## Additional Information

Offending line of code is here.  They call an `unquote` function on the password, but not the username.
https://github.com/coleifer/peewee/blob/master/playhouse/db_url.py#L50

One possible solution is what is being requested in Issue #3179.

This same root cause must be fixed before merging.
REVIEW_EOF
