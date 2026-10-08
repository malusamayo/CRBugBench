#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `studio/components/grid/components/header/filter/FilterPopover.tsx`:

This pull request introduces the defect later reported as "Table editor filter input loses focus after debounce". The
problem a user observed, and its root cause:

See if we can avoid losing focus after debouncing - because we're now updating the URL state with the filter and sorts
otherwise consider only enacting the filter on blur


https://user-images.githubusercontent.com/19742402/192434602-55518258-199d-4e46-9661-429e00a9094f.mov

This same root cause must be fixed before merging.
REVIEW_EOF
