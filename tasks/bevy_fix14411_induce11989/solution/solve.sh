#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `crates/bevy_animation/src/transition.rs`:

This pull request introduces the defect later reported as "Rapid repeated animation transitions break animation". The
problem a user observed, and its root cause:

## Bevy version

current `main` branch (commit 91cd84fea7fa582c5ed029cc3ffe675b1e1bc6c1)

## What you did

Change fox animations too many times too fast in `animated_fox` example.

## What went wrong

The fox stopped animating (despite being supposed to animate forever).

## Draft PR where it's easier to encounter the bug #13909 

Checkout the branch and press Enter many times quickly. (You can use ASDF keys as well)

## Theory

My theory is that transitioning to the same state multiple times breaks the transition code.

Below there are logs for `main_animation` and `transitions` of `AnimationTransitions`.

If you take a look towards the end you will see:
```
Some(NodeIndex(2))
[AnimationTransition { current_weight: 0.0023473431, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(2))
[]
```

As the transition from `NodeIndex(2)` to `NodeIndex(2)` (the same animation) finishes the underlying animation is likely stopped for the transition. However, since the main animation likely reuses the same player it incorrectly stops as well.

As for why it is possible to transition from a state to itself suggests there is a bug in the animation weight decline code.
Since I am using the same animation transition duration and switching between 2 animations, it shouldn't be possible to transition between two of the same animation, unless the transitions decay unevenly. (i.e. transition from `NodeIndex(1)` decays before the transition from `NodeIndex(2)` despite starting later)

<details>
  <summary>
    `AnimationTransitions` logs (Part 1)
  </summary>

Some(NodeIndex(2))
[]
Some(NodeIndex(2))
[]
Some(NodeIndex(2))
[]
Some(NodeIndex(2))
[]
Some(NodeIndex(2))
[]
Some(NodeIndex(2))
[]
Some(NodeIndex(2))
[]
Some(NodeIndex(2))
[]
Some(NodeIndex(2))
[]
Some(NodeIndex(2))
[]
Some(NodeIndex(2))
[]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.99651736, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.99331194, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.98998576, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.98660475, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.98331034, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.97997403, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.9766286, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.9731868, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.9699572, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.9666013, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.96328545, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.9599531, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.9566178, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.9532719, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.94990563, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.946574, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.9432631, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.939924, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.936389, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.9332617, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.9299106, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.9265706, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.9231866, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.91990995, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.9165681, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.9132341, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.9098967, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.90652883, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.90322673, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.8998905, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.89654976, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.8931505, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.88988173, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.88654375, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.8832147, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.8798653, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.8765389, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.87312496, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.8698272, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.86649424, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.8631851, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.8598607, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.8565146, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.85318226, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.8498043, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.84650826, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.8431105, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]
Some(NodeIndex(1))
[AnimationTransition { current_weight: 0.8398324, weight_decline_per_sec: 0.8, animation: NodeIndex(2) }]


This same root cause must be fixed before merging.
REVIEW_EOF
