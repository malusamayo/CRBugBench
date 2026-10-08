# Code Review Task

You are a maintainer reviewing a pull request to the `apache/superset` repository.

**PR title:** fix: Do no aggregate results for CSV downloads from AG Grid raw records table

**PR description:**

### SUMMARY
The AG Grid un-aggregated table is sending `metrics=[]` to the backend when a CSV download is triggered from the dashboard, which makes sense (the un-aggregated chart doesn't have any metrics). In the backend, we validate `if metrics is not None` to decide if a `GROUP BY` should be added, in this case incorrectly evaluating to `True`.

As a consequence, the CSV file would only include distinct rows.

### BEFORE/AFTER SCREENSHOTS OR ANIMATED GIF

**Before**
<img width="2234" height="1582" alt="image" src="https://github.com/user-attachments/assets/24be9a21-7b9b-4055-a1a6-773d9755e244" />


**After**
<img width="2988" height="1732" alt="image" src="https://github.com/user-attachments/assets/1eb205cd-3e38-4868-a132-c227fd50125c" />


### TESTING INSTRUCTIONS
1. Create an un-aggregated AG Grid table using the `cleaned_sales_data` dataset.
2. Use `deal_size` as a column.
3. Save the chart and add it to a dashboard.
4. Access the dashboard.
5. Trigger a CSV download.
6. Validate the CSV includes the same amount of rows returned by the chart.

### ADDITIONAL INFORMATION
<!--- Check any relevant boxes with "x" -->
<!--- HINT: Include "Fixes #nnn" if you are fixing an existing issue -->
- [ ] Has associated issue:
- [ ] Required feature flags:
- [ ] Changes UI
- [ ] Includes DB Migration (follow approval process in [SIP-59](https://github.com/apache/superset/issues/13351))
  - [ ] Migration is atomic, supports rollback & is backwards-compatible
  - [ ] Confirm DB migration upgrade and downgrade tested
  - [ ] Runtime estimates and downtime expectations provided
- [ ] Introduces new feature or API
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
