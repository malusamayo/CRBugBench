#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Infrastructure.EntityFramework/Repositories/OrganizationDomainRepository.cs`:

This pull request introduces the defect later reported as "Domain Verification disappears with no indication why". The
problem a user observed, and its root cause:

### Steps To Reproduce

Set up domain verification, set up the TXT record, see how it says "verified" in the UI.

Wait a few days.

See how the domain is no longer in the UI and Bitwarden asks for an SSO identifier again.
No log entries, nothing in the event log.

### Expected Result

Domain verification _either_ stays (because the TXT record is still present) _or_ an error is logged, explaining why the domain is being removed.

### Actual Result

The domain vanishes without a trace, no error is logged, and we have to set it up again, from scratch.

### Screenshots or Videos

_No response_

### Additional Context

_No response_

### Githash Version

ad8aec9-dirty

### Environment Details

- Unified self-host
- OpenShift

### Database Image

Postgres: 16.4

### Issue-Link

https://github.com/bitwarden/server/issues/2480


### Issue Tracking Info

- [X] I understand that work is tracked outside of Github. A PR will be linked to this issue should one be opened to address it, but Bitwarden doesn't use fields like "assigned", "milestone", or "project" to track progress.

This same root cause must be fixed before merging.
REVIEW_EOF
