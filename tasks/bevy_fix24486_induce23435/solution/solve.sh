#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/bevy_gizmos/src/transform_gizmo.rs`:

This pull request introduces the defect later reported as "[0.19.0-rc.2] Transform gizmo local space snapping renders gizmo unusable". The
problem a user observed, and its root cause:

## Bevy version and features

- Release: 0.19.0-rc.2
- Features: dev

## \[Optional\] Relevant system information

Rust version: `cargo 1.95.0 (f2d3ce0bd 2026-03-21)` (latest as of right now)
OS: Arch Linux

```ignore
AdapterInfo { name: "AMD Radeon RX 7700S (RADV NAVI33)", vendor: 4098, device: 29824, device_type: DiscreteGpu, device_pci_bus_id: "0000:03:00.0", driver: "radv", driver_info: "Mesa 26.1.1-arch1.2", backend: Vulkan, subgroup_min_size: 32, subgroup_max_size: 64, transient_saves_memory: false }
```

## What you did

- Create an object that can be transformed
- Rotate object on a couple axis so local space is not axis-aligned
- Attempt to then transform something in local space with snapping

## What went wrong

Snapping is performed in world-space, which makes rotations buggy and translation completely ignore the local axis you are moving along

## Additional information

Sample code is as in #24429

https://github.com/user-attachments/assets/461f974e-e24b-4259-a136-3161acbbb3ad

This same root cause must be fixed before merging.
REVIEW_EOF
