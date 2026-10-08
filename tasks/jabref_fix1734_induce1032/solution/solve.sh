#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/main/java/net/sf/jabref/specialfields/SpecialFieldsUtils.java`:

This pull request introduces the defect later reported as "ISBN2BibTex  adds the word "Seiten"  in Biblatex pagetotal number ". The
problem a user observed, and its root cause:

JabRef version 3.4  Windows 7 x64

ISBN2BibTex fetcher includes the word "Seiten" in pagetotal.

Sample ISBN:
978-0131873216

In the pagetotal field, I get "988 Seiten".
It should be only the number.
Quote from BibLaTeX manual:

> pagetotal
> field (literal)
> The total number of pages of the work

This same root cause must be fixed before merging.
REVIEW_EOF
