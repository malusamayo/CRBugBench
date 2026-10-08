#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `embassy-stm32/src/rcc/h.rs`:

This pull request introduces the defect later reported as "STM32H7 RM0468 incorrect D1CPRE max". The
problem a user observed, and its root cause:

According to the reference manual (fig. 49), the D1CPRE clock max is 550MHz. This matches what the clock configuration in STM32CubeMX told me before. However, when trying to set a 544MHz clock, I get a crash at runtime, complaining about d1cpre being larger than its maximum value, which in your code is 520MHz:

https://github.com/embassy-rs/embassy/blob/6ff0e4bcf5fbcccd8ae52cc83be7ed9f83b66fde/embassy-stm32/src/rcc/h.rs#L483

I cannot seem to find a reason why the clocks maximum would be 520MHz.

This same root cause must be fixed before merging.
REVIEW_EOF
