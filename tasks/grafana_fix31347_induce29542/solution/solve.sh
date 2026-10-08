#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `public/app/features/plugins/datasource_srv.ts`:

This pull request introduces the defect later reported as "Variables: default DataSource works incorrectly after upgrade to v7.4.2". The
problem a user observed, and its root cause:

<!--
Please use this template to create your bug report. By providing as much info as possible you help us understand the issue, reproduce it and resolve it for you quicker. Therefor take a couple of extra minutes to make sure you have provided all info needed.

PROTIP: record your screen and attach it as a gif to showcase the issue.

- Questions should be posted to: https://community.grafana.com
- Use query inspector to troubleshoot issues: https://bit.ly/2XNF6YS
- How to record and attach gif: https://bit.ly/2Mi8T6K
-->
Hi,
with regard to https://github.com/grafana/grafana/issues/30996 I'm opening this issue as follows:

**What happened**:
After upgrade to 7.4.2 version selecting a _default_ DS (within a query editor) from a **variable** does not work properly.
When there's the `default` DS being selected within the **variable**, it's impossible to select the _default_ DS (i.e. `${variable_name} (default)` item) in the "Data Sources menu".
You need to select other than `default` DS in the **variable** first, then you can select the _default_ DS.

**What you expected to happen**:
One can select the `default` DS the "Data Sources menu" in one go.

**How to reproduce it (as minimally and precisely as possible)**:
See above, please.

**Anything else we need to know?**:

**Environment**:
- Grafana version: 7.4.2
- Data source type & version:
- OS Grafana is installed on:
- User OS & Browser:
- Grafana plugins:
- Others:

This same root cause must be fixed before merging.
REVIEW_EOF
