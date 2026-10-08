#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `java/client/src/org/openqa/selenium/virtualauthenticator/VirtualAuthenticatorOptions.java`:

This pull request introduces the defect later reported as "Virtual authenticator member enums should be public". The
problem a user observed, and its root cause:

## 🐛 Bug Report

The `enum`s on VirtualAuthenticatorOptions are package-private due to an oversight but they should be public instead.

## To Reproduce

Try setting the Protocol or Transport on VirtualAuthenticatorOptions.

## Expected behavior

It works.

## Test script or set of commands reproducing this issue

```java
VirtualAuthenticatorOptions options = new VirtualAuthenticatorOptions().setProtocol(Protocol.U2F);
```

## Environment

Any.

This same root cause must be fixed before merging.
REVIEW_EOF
