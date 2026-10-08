#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Aspire.Hosting/Dashboard/DashboardViewModelService.cs`:

This pull request introduces the defect later reported as "Dashboard isn't showing all exes". The
problem a user observed, and its root cause:

I just updated one of my prototypes to use the latest aspire.hosting and somehow the worker executable isn't in list of running processes. DCP shows me the process:

```
NAME            CREATED AT
hello           2023-10-17T02:45:15Z
proxy           2023-10-17T02:45:15Z
uploadservice   2023-10-17T02:45:15Z
web             2023-10-17T02:45:15Z
worker          2023-10-17T02:45:15Z
```

<img width="266" alt="image" src="https://github.com/dotnet/aspire/assets/95136/def01331-b2a2-4133-aff6-0d8c49aeade7">

This same root cause must be fixed before merging.
REVIEW_EOF
