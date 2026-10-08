#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `backend/open_webui/utils/oauth.py`:

This pull request introduces the defect later reported as "Setting OAUTH_USERNAME_CLAIM has no effect on username for user during oauth signup". The
problem a user observed, and its root cause:

# Bug Report

## Installation Method

Docker

## Environment

- **Open WebUI Version: v0.5.10
- **Operating System: Linux

**Confirmation:**

- [x] I have read and followed all the instructions provided in the README.md.
- [x] I am on the latest version of both Open WebUI and Ollama.
- [ ] I have included the browser console logs.
- [ ] I have included the Docker container logs.
- [x] I have provided the exact steps to reproduce the bug in the "Steps to Reproduce" section below.

## Expected Behavior:

Username should be set to the value of `OAUTH_USERNAME_CLAIM` found in the response returned by OAuth client.

## Actual Behavior:

User's email is set as username

## Description

**Bug Summary:**
The `OAUTH_USERNAME_CLAIM` environment variable currently does not affect the choice of username for users who signed up through OAuth. 
This is due to a bug that sets the username to be the email if there's no user found on the DB with the same `sub`, when in fact there should not be such user on DB during first sign up.

Instead of checking if there's a user, this PR checks if there's a key matching value of `OAUTH_USERNAME_CLAIM` in the `user_data` OAuth client response, email is only used when such key is not found.

## Reproduction Details

**Steps to Reproduce:**

- Enable any OAuth providers by following [this guide](https://docs.openwebui.com/features/sso)
- Set `ENABLE_SIGNIN_FROM`, `ENABLE_SIGNUP` to `false` and `ENABLE_OAUTH_SIGNUP` to `true`
- Start open-webui with `docker run -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main`
- Click on "Continue with your-oauth-provider`
- Observe the username in the lower left of the UI

This same root cause must be fixed before merging.
REVIEW_EOF
