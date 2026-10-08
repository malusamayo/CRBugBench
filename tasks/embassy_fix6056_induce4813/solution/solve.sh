#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `embassy-stm32/src/backup_sram.rs`:

This pull request introduces the defect later reported as "Hardfault due to unaligned access to BACKUP SRAM". The
problem a user observed, and its root cause:

Hi,

The [BackupMemory::new](https://docs.embassy.dev/embassy-stm32/git/stm32h523re/backup_sram/struct.BackupMemory.html#method.new) returns a slice of u8 memory. I have run into a situation where the compiler coalesces multiple `u8` backupsram accesses into one unaligned 32bit wide access. This HardFaults my program.

I struggle to find much info on whether unaligned access should be allowed for BKPSRAM. However, digging through [Arm v8-M Architecture Reference Manual DDI0553B.z](https://developer.arm.com/documentation/ddi0553/latest/) Device memory B7.11 it states that:

> Any unaligned access to Device memory generates an UNALIGNED UsageFault exception.

So in that case, I take it `BackupMemory::new` is unsound?

This same root cause must be fixed before merging.
REVIEW_EOF
