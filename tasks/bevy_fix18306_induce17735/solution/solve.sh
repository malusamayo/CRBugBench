#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/bevy_core_pipeline/src/core_2d/main_transparent_pass_2d_node.rs`:

This pull request introduces the defect later reported as "Sprite in `bloom_2d` example is not rendered". The
problem a user observed, and its root cause:

## Bevy version

main, bisected to #17735

## Relevant system information

`SystemInfo { os: "macOS 15.3 Sequoia", kernel: "24.3.0", cpu: "Apple M4 Max", core_count: "16", memory: "64.0 GiB" }`
`AdapterInfo { name: "Apple M4 Max", vendor: 0, device: 0, device_type: IntegratedGpu, driver: "", driver_info: "", backend: Metal }`

But this also reproduces in CI in [the example report](https://thebevyflock.github.io/bevy-example-runner/).

## What you did

`cargo run --example bloom_2d`

## What went wrong

The bevy logo sprite that should be displayed in the center of the screen is not.

This same root cause must be fixed before merging.
REVIEW_EOF
