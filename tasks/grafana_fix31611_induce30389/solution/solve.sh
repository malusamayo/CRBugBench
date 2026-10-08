#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `public/app/features/dashboard/state/getPanelOptionsWithDefaults.test.ts`:

This pull request introduces the defect later reported as "Colors of non-graph visualisation are reset to Grey every time a Graph visualisation is toggled/untoggled". The
problem a user observed, and its root cause:

<!--
Please use this template to create your bug report. By providing as much info as possible you help us understand the issue, reproduce it and resolve it for you quicker. Therefor take a couple of extra minutes to make sure you have provided all info needed.

PROTIP: record your screen and attach it as a gif to showcase the issue.

- Questions should be posted to: https://community.grafana.com
- Use query inspector to troubleshoot issues: https://bit.ly/2XNF6YS
- How to record and attach gif: https://bit.ly/2Mi8T6K
-->

**What happened**: Whenever a visualisation is set to Graph then set back to a non-Graph visualisation, all the colours set themselves to grey.

**What you expected to happen**: Default colour scheme for visualisations should work if not specified, specified colours should be retained.

**How to reproduce it (as minimally and precisely as possible)**:
- Create a new panel (or edit any existing panel)
- Return some data from the panel (enter some query)
- If the panel started as Graph, set it to a non-Graph, colours will be fine, then set it to Graph/Time Series and back again, colours will be grey
- If the panel started as non-graph (existing panel), set it to Graph, then back again, colours will be Grey

**Anything else we need to know?**:

**Environment**:
- Grafana version: 7.4.2 (Enterprise)
- Data source type & version: Any data source, tested with Prometheus, Datadog, Google Sheets
- OS Grafana is installed on: Linux (GKE)
- User OS & Browser: Firefox 85.0.1 for Ubuntu (elementaryOS 5.1), but occurred on other machines too
- Grafana plugins: Core
- Others:

Gif:
![grafana-visualisation-colour-issue](https://user-images.githubusercontent.com/11842311/109229411-1bbbb780-7778-11eb-8404-75c9211bee97.gif)

This same root cause must be fixed before merging.
REVIEW_EOF
