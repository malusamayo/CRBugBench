#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `apps/studio/components/layouts/TableEditorLayout/EntityListItem.tsx`:

This pull request introduces the defect later reported as "Export CSV not working on local development instance". The
problem a user observed, and its root cause:

# Bug report

- [x] I confirm this is a bug with Supabase, not with my own application. 
- [x] I confirm I have searched the [Docs](https://docs.supabase.com), GitHub [Discussions](https://github.com/supabase/supabase/discussions), and [Discord](https://discord.supabase.com). 

## Describe the bug

On the Studio URL: http://127.0.0.1:54323, in a table, I tried to export table data by clicking on `Export as CSV` but nothing happened.
 
## To Reproduce

1. Run a local development Supabase instance and go to the Studio URL: http://127.0.0.1:54323
2. Make sure you have a table with some rows and data in them
3. In the left side menu, click on the arrow next to the table name and click `Export as CSV`
4. See? Nothing happens, no download, no error displayed. 

## Expected behavior

A CSV file should be downloaded. I tried on the hosted Supabase instance and it works as expected. 

## System information

- OS: macOS 13.2.1 Ventura
- Browser (if applies) Arc and Firefox

<img width="644" alt="image" src="https://github.com/supabase/supabase/assets/4534234/99925cad-2a02-4473-8571-b773ace3b313">

This same root cause must be fixed before merging.
REVIEW_EOF
