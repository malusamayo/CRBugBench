#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/main/java/stirling/software/SPDF/config/security/UserAuthenticationFilter.java`:

This pull request introduces the defect later reported as "[Bug] NullPointerException on authentication since 0.28.2". The
problem a user observed, and its root cause:

Hi,

Seems like authentication fails since the changes on [this commit](https://github.com/Stirling-Tools/Stirling-PDF/commit/81e2a77e57f884dfae6a772086a1aaba43690abf) with a NullPointerException on [these lines](https://github.com/Stirling-Tools/Stirling-PDF/blob/81e2a77e57f884dfae6a772086a1aaba43690abf/src/main/java/stirling/software/SPDF/config/security/UserAuthenticationFilter.java#L61C21-L62C45)

I think [this method](https://github.com/Stirling-Tools/Stirling-PDF/blob/main/src/main/java/stirling/software/SPDF/config/security/UserService.java#L125C1-L132C6) should return `Optional.empty()` instead of `null` 🤔 

Unfortunately I don't have a Java IDE nor have the time to investigate this more, hope this is still useful 🙂

This same root cause must be fixed before merging.
REVIEW_EOF
