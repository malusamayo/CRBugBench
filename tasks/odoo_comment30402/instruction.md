# Code Review Task

You are a maintainer reviewing a pull request to the `odoo/odoo` repository.

**PR title:** [FIX] base ir.actions.report order pdfs when attachment_use option selected

**PR description:**

Description of the issue/feature this PR addresses:
Order of merged pdf reports when attachment_use = True

Current behaviour before PR:
When in a report the "Reload from Attachment" option was selected
(attachment_use = True), and multiple pdfs were printed, the singular pdfs
were stored in a dictionary and appended to a list and thus merged in a random order.

Desired behaviour after PR is merged:
By mapping the pdf with their source record, and sorting the list with the table _order of
the source records of the pdfs, we seek to have an ordered output pdf.

opw 1915685

--
I confirm I have signed the CLA and read the PR guidelines at www.odoo.com/submit-pr

## Working environment

The repository is checked out at `/app/odoo` at this PR's **base commit**
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
