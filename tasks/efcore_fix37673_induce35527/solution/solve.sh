#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/EFCore.Tools/tools/EntityFrameworkCore.psm1`:

This pull request introduces the defect later reported as "VS 2026: Package Manage Console now requires "-ErrorAction Ignore" parameter on all EF commands". The
problem a user observed, and its root cause:

_This issue has been moved from [a ticket on Developer Community](https://developercommunity.visualstudio.com/t/VS-2026:-Package-Manage-Console-now-requ/11034987)._

---
[severity:It's more difficult to complete my work] [regression] [worked-in:17 (vs 2022)]
Since upgrading to VS 2026, If i try to run any EF-related commands, the command will fail. Commands include:

add-migration
remove-migration
update-database

With the error:
"The running command stopped because the preference variable "ErrorActionPreference" or common parameter is set to Stop"

These are failing, and have to be appended with ErrorAction Ignore, like:

add-migration "mymigration" -ErrorAction Ignore

The error still displays in the console, but the action continues successfully. The error is technically valid; in my case it is complaining because of nuget 'package vulnerability'. But this shouldn't stop all package manager console commands.

I do have the workaround, but I would appreciate a fix. Thanks!

---
### Original Comments

#### Feedback Bot on 1/27/2026, 05:17 PM: 

<p>We have directed your feedback to the appropriate engineering team for further evaluation. The team will review the feedback and notify you about the next steps.</p>

#### Feedback Bot on 2/11/2026, 09:15 AM: 

<p>This issue is currently being investigated. Our team will get back to you if either more information is needed, a workaround is available, or the issue is resolved.</p>

This same root cause must be fixed before merging.
REVIEW_EOF
