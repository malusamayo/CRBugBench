#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `embassy-nrf/src/time_driver.rs`:

This pull request introduces the defect later reported as "nrf54l15 stall when syscounter is high at start". The
problem a user observed, and its root cause:

When running on main (or, more specifically, 0.10.0 with #5830 applied) I can consistently hit a stall if I use join() to manage concurrent async functions. Execution seems to stop for however long Instant::now() returns at program start (ie, initial syscounter value), before successfully resuming. Example output for the program below:

```
56.659337 [INFO ] Starting... (nrf54l15_timer_repro nrf54l15-timer-repro/src/main.rs:38)
56.659731 [INFO ] joined_fn start (nrf54l15_timer_repro nrf54l15-timer-repro/src/main.rs:16)
<approximately 56s of wall clock time passes here without any output>
57.660345 [INFO ] joined_fn loop (nrf54l15_timer_repro nrf54l15-timer-repro/src/main.rs:19)
57.660974 [INFO ] main loop (nrf54l15_timer_repro nrf54l15-timer-repro/src/main.rs:42)
58.660959 [INFO ] joined_fn loop (nrf54l15_timer_repro nrf54l15-timer-repro/src/main.rs:19)
58.661588 [INFO ] main loop (nrf54l15_timer_repro nrf54l15-timer-repro/src/main.rs:42)
... output continues reliably as expected ...
```

The minimal repro is at https://github.com/rcloran/nrf54l15-timer-repro , but here's the (trimmed of comments) main.rs:

```rust
#![no_std]
#![no_main]

use embassy_executor::Spawner;
use embassy_futures::join::join;
use embassy_time::Timer;

use defmt_rtt as _;
use panic_probe as _;

// Some early attempts at repros suggested that using timestamp in log was a contributing factor,
// but this repro works with or without defmt::timestamp!().
defmt::timestamp!("{=u64:us}", embassy_time::Instant::now().as_micros());

async fn joined_fn() {
    defmt::info!("joined_fn start");
    loop {
        Timer::after_millis(1000).await;
        defmt::info!("joined_fn loop");
    }
}

#[embassy_executor::main]
async fn main(_spawner: Spawner) {
    cortex_m::asm::delay(320_000); // ~50ms, avoids hard fault if debugger attached early

    embassy_nrf::init(Default::default());

    defmt::info!("Starting...");
    join(joined_fn(), async {
    loop {
        Timer::after_millis(1000).await;
        defmt::info!("main loop");
    }
    }).await;
}
```

The procedure I use to demonstrate this without too long of a pause:

 - Flash the firmware
 - Power cycle the device (clears syscounter)
 - Let the program run a few seconds
 - `probe-rs reset --chip nrf54l15`
 - Note that the program now stalls for about however long the initial log line's timestamp was

Running embassy-nrf 0.10.0 without any patches applied does not exhibit this behaviour, but I do see other stalls with that at other random times. Just setting `set_autoen(Autoen::CPU_ACTIVE)` seems to resolve those.

I've been trying to study this and understand the interactions, but I'm coming up nowhere.

01d8543 seems suspicious, but reverting it doesn't help.

@whmountains commented about similar symptoms in comments of #5591

This same root cause must be fixed before merging.
REVIEW_EOF
