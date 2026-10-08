#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Emby.Server.Implementations/Cryptography/CryptographyProvider.cs`:

This pull request introduces the defect later reported as "CryptographyProvider.Verify crashes with KeyNotFoundException when password hash is missing iterations parameter". The
problem a user observed, and its root cause:

### Description

When a password hash stored in the database doesn't include the `iterations` parameter, calling `CryptographyProvider.Verify()` throws a `KeyNotFoundException` instead of handling the error gracefully.

This can happen if:
- Password was stored using an older format
- Database contains malformed/corrupted password data
- A hash string like `$PBKDF2$69F420$62FBA410AFCA5B...` (valid per PasswordHash.Parse) is used

### Reproduction Steps

1. Parse a password hash without iterations: `PasswordHash.Parse("$PBKDF2$69F420$62FBA410AFCA5B4475F35137AB2E8596B127E4D927BA23F6CC05C067E897042D")`
2. Call `cryptographyProvider.Verify(hash, "anypassword")`
3. Observe `KeyNotFoundException` thrown at line 46

### Expected Behavior

The method should throw a descriptive exception explaining the missing or invalid parameter.

### Actual Behavior

Unhandled `KeyNotFoundException: The given key 'iterations' was not present in the dictionary.`

### Code Location

https://github.com/jellyfin/jellyfin/blob/master/Emby.Server.Implementations/Cryptography/CryptographyProvider.cs#L46

### Environment

- Jellyfin Version: master
- OS: All platforms

This same root cause must be fixed before merging.
REVIEW_EOF
