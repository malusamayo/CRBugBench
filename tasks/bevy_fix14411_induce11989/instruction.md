# Code Review Task

You are a maintainer reviewing a pull request to the `bevyengine/bevy` repository.

**PR title:** Implement the `AnimationGraph`, allowing for multiple animations to be blended together. (#11989)

**PR description / commit message:**

Implement the `AnimationGraph`, allowing for multiple animations to be blended together. (#11989)

This is an implementation of RFC #51:
https://github.com/bevyengine/rfcs/blob/main/rfcs/51-animation-composition.md

Note that the implementation strategy is different from the one outlined
in that RFC, because two-phase animation has now landed.

# Objective

Bevy needs animation blending. The RFC for this is [RFC 51].

## Solution

This is an implementation of the RFC. Note that the implementation
strategy is different from the one outlined there, because two-phase
animation has now landed.

This is just a draft to get the conversation started. Currently we're
missing a few things:

- [x] A fully-fleshed-out mechanism for transitions
- [x] A serialization format for `AnimationGraph`s
- [x] Examples are broken, other than `animated_fox`
- [x] Documentation

---

## Changelog

### Added

* The `AnimationPlayer` has been reworked to support blending multiple
animations together through an `AnimationGraph`, and as such will no
longer function unless a `Handle<AnimationGraph>` has been added to the
entity containing the player. See [RFC 51] for more details.

* Transition functionality has moved from the `AnimationPlayer` to a new
component, `AnimationTransitions`, which works in tandem with the
`AnimationGraph`.

## Migration Guide

* `AnimationPlayer`s can no longer play animations by themselves and
need to be paired with a `Handle<AnimationGraph>`. Code that was using
`AnimationPlayer` to play animations will need to create an
`AnimationGraph` asset first, add a node for the clip (or clips) you
want to play, and then supply the index of that node to the
`AnimationPlayer`'s `play` method.

* The `AnimationPlayer::play_with_transition()` method has been removed
and replaced with the `AnimationTransitions` component. If you were
previously using `AnimationPlayer::play_with_transition()`, add all
animations that you were playing to the `AnimationGraph`, and create an
`AnimationTransitions` component to manage the blending between them.

[RFC 51]:
https://github.com/bevyengine/rfcs/blob/main/rfcs/51-animation-composition.md

---------

Co-authored-by: Rob Parrett <robparrett@gmail.com>

## Working environment

The repository is checked out at `/app/bevy` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
