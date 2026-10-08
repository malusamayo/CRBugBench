#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `apps/docs/pages/guides/auth/auth-helpers/sveltekit.mdx`:

This pull request introduces the defect later reported as "Tutorial results in error: You are assigning to a const". The
problem a user observed, and its root cause:

Fairly new to Svelte and some of its syntax, but was following the [linked tutorial](https://supabase.com/docs/guides/auth/auth-helpers/sveltekit?language=js#:~:text=const%20%7B%20supabase%2C%20session%20%7D%20%3D%20data) and it gives an error in VSCode: "You are assigning to a const"

The particular piece giving the error is:

```
const { supabase, session } = data
$: ({ supabase, session } = data)
```

Looks to have been [a commit](https://github.com/supabase/supabase/commit/b09243b628c4f47c98fff0d89c08f561865ae56b) changing it from "let" to "const", and when I switch it back, it seems to work. Whilst it would appear that commit was changing a lot of other let references to const, would like to understand if that is the correct thing to do in this scenario, or if it should be handled in another way?

This same root cause must be fixed before merging.
REVIEW_EOF
