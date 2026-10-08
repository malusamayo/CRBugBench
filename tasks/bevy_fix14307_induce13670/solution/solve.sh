#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/bevy_math/src/direction.rs`:

This pull request introduces the defect later reported as "Wildly inconsistent documentation on Dir2 <-> Rot2 conversion methods.". The
problem a user observed, and its root cause:

## How can Bevy's documentation be improved?

https://github.com/bevyengine/bevy/blob/d7080369a7471e6aa9747bad41a4469092f9967b/crates/bevy_math/src/direction.rs#L219-L245

```rust
    /// Get the rotation that rotates this direction to the Y-axis.
    #[inline]
    pub fn rotation_from_y(self) -> Rot2 {
```
This docstring is imho completely backwards to what it should say, notably, it is backwards to what the docstring for `rotation_from_x` says.

## Solution

Figure out which way the methods *actually* go, and update the docstrings appropriately. (Imo the semantics on the x-axis functions are correct, and the doc strings on the y-axis functions are wrong.)

This same root cause must be fixed before merging.
REVIEW_EOF
