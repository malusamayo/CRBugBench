#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Servers/Kestrel/Core/src/Internal/Infrastructure/KestrelTrace.cs`:

This pull request introduces the defect later reported as "Duplicated event names in KestrelTrace logger". The
problem a user observed, and its root cause:

In KestrelTrace logger declared two events with same name `"RequestBodyDrainTimedOut"`

https://github.com/dotnet/aspnetcore/blob/4f3e8e0efffc1a6fed471d1376db5afcefed21a6/src/Servers/Kestrel/Core/src/Internal/Infrastructure/KestrelTrace.cs#L85-L89

This same root cause must be fixed before merging.
REVIEW_EOF
