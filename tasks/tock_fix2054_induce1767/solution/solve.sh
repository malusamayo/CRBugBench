#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `kernel/src/sched/round_robin.rs`:

This pull request introduces the defect later reported as "Scheduler panic on STM32F4xx". The
problem a user observed, and its root cause:

I am running into the following fault when running one app (an most probably the same with more) on stm32f4xx.

```
panicked at 'attempt to subtract with overflow', kernel/src/sched/round_robin.rs:81:18
	Kernel version release-1.5-905-g39cf73e40

---| No debug queue found. You can set it with the DebugQueue component.

---| Fault Status |---
No faults detected.

---| App Status |---
App: screen   -   [Yielded]
 Events Queued: 0   Syscall Count: 22   Dropped Callback Count: 0
 Restart Count: 0
 Last Syscall: Some(YIELD)

 ╔═══════════╤══════════════════════════════════════════╗
 ║  Address  │ Region Name    Used | Allocated (bytes)  ║
 ╚0x20018000═╪══════════════════════════════════════════╝
             │ ▼ Grant        1228 |   1228          
  0x20017B34 ┼───────────────────────────────────────────
             │ Unused
  0x2001107C ┼───────────────────────────────────────────
             │ ▲ Heap         1524 |  28844               S
  0x20010A88 ┼─────────────────────────────────────────── R
             │ Data            648 |    648               A
  0x20010800 ┼─────────────────────────────────────────── M
             │ ▼ Stack         480 |   2048          
  0x20010620 ┼───────────────────────────────────────────
             │ Unused
  0x20010000 ┴───────────────────────────────────────────
             .....
  0x08042000 ┬─────────────────────────────────────────── F
             │ App Flash      8148                        L
  0x0804002C ┼─────────────────────────────────────────── A
             │ Protected        44                        S
  0x08040000 ┴─────────────────────────────────────────── H

  R0 : 0x20011070    R6 : 0x0000000C
  R1 : 0x20010928    R7 : 0x20011058
  R2 : 0x00000000    R8 : 0x20010A80
  R3 : 0x00000000    R10: 0x00000000
  R4 : 0x20011070    R11: 0x00000000
  R5 : 0x00000000    R12: 0x00000000
  R9 : 0x20010800 (Static Base Register)
  SP : 0x20010620 (Process Stack Pointer)
  LR : 0x0804075B
  PC : 0x0804073C
 YPC : 0x0804073C

 APSR: N 0 Z 1 C 1 V 0 Q 0
       GE 0 0 0 0
 EPSR: ICI.IT 0x00
       ThumbBit true 

 Cortex-M MPU
  Region 0: [0x20010000:0x20018000], length: 32768 bytes; ReadWrite (0x3)
    Sub-region 0: [0x20010000:0x20011000], Enabled
    Sub-region 1: [0x20011000:0x20012000], Enabled
    Sub-region 2: [0x20012000:0x20013000], Disabled
    Sub-region 3: [0x20013000:0x20014000], Disabled
    Sub-region 4: [0x20014000:0x20015000], Disabled
    Sub-region 5: [0x20015000:0x20016000], Disabled
    Sub-region 6: [0x20016000:0x20017000], Disabled
    Sub-region 7: [0x20017000:0x20018000], Disabled
  Region 1: [0x08040000:0x08042000], length: 8192 bytes; ReadOnly (0x6)
    Sub-region 0: [0x08040000:0x08040400], Enabled
    Sub-region 1: [0x08040400:0x08040800], Enabled
    Sub-region 2: [0x08040800:0x08040C00], Enabled
    Sub-region 3: [0x08040C00:0x08041000], Enabled
    Sub-region 4: [0x08041000:0x08041400], Enabled
    Sub-region 5: [0x08041400:0x08041800], Enabled
    Sub-region 6: [0x08041800:0x08041C00], Enabled
    Sub-region 7: [0x08041C00:0x08042000], Enabled
  Region 2: Unused
  Region 3: Unused
  Region 4: Unused
  Region 5: Unused
  Region 6: Unused
  Region 7: Unused

To debug, run `make debug RAM_START=0x20010000 FLASH_INIT=0x8040055`
in the app's folder and open the .lst file.

```

I patched the scheduler in the following way and it seems to work:

```rust
impl<'a, C: Chip> Scheduler<C> for RoundRobinSched<'a> {
    fn next(&self, kernel: &Kernel) -> SchedulingDecision {
        if kernel.processes_blocked() {
            // No processes ready
            SchedulingDecision::TrySleep
        } else {
            let next = self.processes.head().unwrap().appid;
            let timeslice = if self.last_rescheduled.get() {
                self.time_remaining.get()
            } else {
                self.time_remaining.set(Self::DEFAULT_TIMESLICE_US);
                Self::DEFAULT_TIMESLICE_US
            };
            assert!(timeslice != 0);

            SchedulingDecision::RunProcess((next, Some(timeslice)))
        }
    }

    fn result(&self, result: StoppedExecutingReason, execution_time_us: Option<u32>) {
        let execution_time_us = execution_time_us.unwrap(); // should never fail
        self.time_remaining
            .set(if self.time_remaining.get() >= execution_time_us {
                self.time_remaining.get() - execution_time_us
            } else {
                1 // 0 will fail assert
            });
        let reschedule = match result {
            StoppedExecutingReason::KernelPreemption => true,
            _ => false,
        };
        self.last_rescheduled.set(reschedule);
        if !reschedule {
            self.processes.push_tail(self.processes.pop_head().unwrap());
        }
    }
}
```

It seems that the time_remaining was never reset. Was this intentional?

This same root cause must be fixed before merging.
REVIEW_EOF
