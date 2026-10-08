#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `lib/helpers/combineURLs.js`:

This pull request introduces the defect later reported as "API endpoints with file extensions". The
problem a user observed, and its root cause:

Hello! Great project.

To jump right in, it is a hacky experience to create an axios client for a single-endpoint API that also uses a file extension. ie `https://coolapi.com/api.php`

All url requests make their way through `combineURLs.js`, to be appended with a `/` regardless of if there was a relative url attached to the client's request config.

The current hack (it feels like hack...) to get around this is to add a request interceptor to remove the ending slash. I'm currently doing this in a project.

Happy to PR this issue with a fix to combineURLs - but I want to run it past owners first for validity.

Cheers! ✨

This same root cause must be fixed before merging.
REVIEW_EOF
