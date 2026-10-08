#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `apps/studio/data/enumerated-types/enumerated-type-delete-mutation.ts`:

This pull request introduces the defect later reported as "Unable to Delete Enumerated Types from Dashboard". The
problem a user observed, and its root cause:

# Bug report

- [ ✅ ] I confirm this is a bug with Supabase, not with my own application. 
- [ ✅ ] I confirm I have searched the [Docs](https://docs.supabase.com), GitHub [Discussions](https://github.com/supabase/supabase/discussions), and [Discord](https://discord.supabase.com). 

## Describe the bug


I am able to successfully create new enumerated types with upper-case or lower-case values. But when I try to delete something with uppercase values, a success message is returned, but the type is still present even after a page reload.

## To Reproduce

1. Go to 'Dashboard --> Database --> Enumerated Types'
2. Click on 'Create Type'
4. Add type with lower-case letters only word
5. Add type with upper-case and lower-case letters containing word
6. Try deleting both, you will see a success message, but really, only the lower-case one is actually deleted

## Expected behavior

case-sensitivity shouldn't matter for deletion being successful. It should just be able to delete.

## System information

- OS: macOS 14.1.2
- Browser: Chrome

## Additional context

Going to SQL Editor and running the following allows me to delete any enumerated type. If I don't include the paranthesis, it changes whatever I enter into lower-case and gives me an error saying no such enumerated type exists. With parentheses, everything works fine. Maybe something in the backend without parenthesis causing this bug?

```sql
DROP type "Test"
```

This same root cause must be fixed before merging.
REVIEW_EOF
