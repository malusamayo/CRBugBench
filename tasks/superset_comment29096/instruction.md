# Code Review Task

You are a maintainer reviewing a pull request to the `apache/superset` repository.

**PR title:** feat(alerts): enable tab selection for dashboard alerts/reports

**PR description:**

<!---
Please write the PR title following the conventions at https://www.conventionalcommits.org/en/v1.0.0/
Example:
fix(dashboard): load charts correctly
-->

### SUMMARY
<!--- Describe the change below, including rationale and design decisions -->
Implements a new feature enabling a tab to be selected as a view for an alert/report. When a dashboard is selected as the content for a report, an antd TreeSelect component is rendered to load and select tab options. When selected, the tab selection is added to the report payload as an anchor.

On execution, the feature takes advantage of existing logic for the report.extra.dashboard.anchor_tab attribute of the ReportSchedule SQLA model. When extra metadata are attached to the report schedule, a permalink is generated with the metadata included, and this permalink is then used to generate screenshots of the selected dashboard.

### BEFORE/AFTER SCREENSHOTS OR ANIMATED GIF
<!--- Skip this if not applicable -->
https://www.loom.com/share/e075b22bd5574e30bcf3bbec5984884f?sid=aeefd476-bf0a-4289-b13f-6b5fe2854156

### TESTING INSTRUCTIONS
<!--- Required! What steps can be taken to manually verify the changes? -->
Create a tab or tabs within an existing dashboard
Navigate to the alerts and reports listview from the settings menu
Create a new report
Under the content section select the dashboard
A selection field for tabs should appear with the tabs available within the select options
select a tab and save the report with the other required fields
at the selected interval, a report should be sent out with the selected tab in focus

### ADDITIONAL INFORMATION
<!--- Check any relevant boxes with "x" -->
<!--- HINT: Include "Fixes #nnn" if you are fixing an existing issue -->
- [ ] Has associated issue:
- [x] Required feature flags: ALERT_REPORTS, ALERT_REPORT_TABS
- [x] Changes UI
- [ ] Includes DB Migration (follow approval process in [SIP-59](https://github.com/apache/superset/issues/13351))
  - [ ] Migration is atomic, supports rollback & is backwards-compatible
  - [ ] Confirm DB migration upgrade and downgrade tested
  - [ ] Runtime estimates and downtime expectations provided
- [x] Introduces new feature or API
- [ ] Removes existing feature or API

## Working environment

The repository is checked out at `/app/superset` at this PR's **base commit**
(the state before this PR), and the proposed change is present two ways:

- applied as **uncommitted modifications** to the working tree (run `git diff`
  to see it, or use a review tool that inspects the local git diff), and
- saved as a unified diff at `/app/pr_to_review.diff`.

Use `git log` and `git show HEAD:<path>` (HEAD is the base commit) for
surrounding history, call sites, and conventions.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
