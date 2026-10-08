#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `embassy-macros/src/lib.rs`:

This pull request introduces the defect later reported as "`rtc_async` example does not work on nrf52810". The
problem a user observed, and its root cause:

```
    Finished dev [optimized + debuginfo] target(s) in 1.27s
     Running `probe-run --chip nRF52810_xxAA C:\Users\XXX\embassy\target\thumbv7em-none-eabi\debug\rtc_async`
  (HOST) INFO  flashing program (19.04 KiB)
  (HOST) INFO  success!
────────────────────────────────────────────────────────────────────────────────
0.000000 INFO  Hello World!
└─ rtc_async::__cortex_m_rt_main @ src\bin\rtc_async.rs:41
0.000001 INFO  tick
└─ rtc_async::run2::task::{{closure}} @ src\bin\rtc_async.rs:30
0.000002 INFO  BIG INFREQUENT TICK
└─ rtc_async::run1::task::{{closure}} @ src\bin\rtc_async.rs:22
```

Stuck at this forever.

The `async_raw` example runs as expected, so the bug might not actually be in the RTC code.

This same root cause must be fixed before merging.
REVIEW_EOF
