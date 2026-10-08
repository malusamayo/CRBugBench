#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/hyperswitch_connectors/src/connectors/cybersource.rs`:

This pull request introduces the defect later reported as "[BUG] The Noon connector was incorrectly storing `class_description` in the `error_message` field instead of the actual error `message`. This affects GSM consistency.". The
problem a user observed, and its root cause:

### Bug Description

The Noon connector's error response mapping was storing `class_description` (a classification/category) in the `error_message` field instead of the actual error `message` from Noon's API response.

### Expected Behavior

It should store actual error message in the `error_message` field.

### Actual Behavior

The Noon connector's error response mapping was storing `class_description` (a classification/category) in the `error_message` field instead of the actual error `message` from Noon's API response.

### Steps To Reproduce

Provide an unambiguous set of steps to reproduce this bug. Include code or configuration to reproduce, if relevant.
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'


### Context For The Bug

_No response_

### Environment

Are you using hyperswitch hosted version? Yes/No
If yes, please provide the value of the `x-request-id` response header to help us debug your issue.

If not (or if building/running locally), please provide the following details:
1. Operating System or Linux distribution:
2. Rust version (output of `rustc --version`): ``
3. App version (output of `cargo r --features vergen -- --version`): ``


### Have you spent some time checking if this bug has been raised before?

- [x] I checked and didn't find a similar issue

### Have you read the Contributing Guidelines?

- [x] I have read the [Contributing Guidelines](https://github.com/juspay/hyperswitch/blob/main/docs/CONTRIBUTING.md)

### Are you willing to submit a PR?

Yes, I am willing to submit a PR!

This same root cause must be fixed before merging.
REVIEW_EOF
