#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `pkg/services/sqlstore/migrator/mysql_dialect.go`:

This pull request introduces the defect later reported as "Alerts are going to everyone and not to specified recipients". The
problem a user observed, and its root cause:

- **I'm submitting a ...**
- [x] Bug report
- [ ] Feature request
- [ ] Question / Support request: **Please do not** open a github issue. [Support Options](http://grafana.org/support/)

Please include this information:
- What Grafana version are you using? Nightly Build
- What datasource are you using? Graphite/OpenTSDB
- What OS are you running grafana on? Amazon Linux
- What did you do? Setup an alert and did not configure any notification recipient.
- What was the expected result? No one should be notified about it.
- What happened instead? Everyone got notified. :(

This same root cause must be fixed before merging.
REVIEW_EOF
