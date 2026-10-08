# Code Review Task

You are a maintainer reviewing a pull request to the `bevyengine/bevy` repository.

**PR title:** upstream: jackdaw transform gizmo (#23435)

**PR description / commit message:**

upstream: jackdaw transform gizmo (#23435)

# Objective

Upstream `jackdaw`'s `TransformGizmo`!

## Solution

Add `TransformGizmoPlugin` to bevy_gizmos as an optional plugin that
draws on a focused entity and lets the user click/drag to manipulate its
transform. Rotate, Translate, and Scale are all individual gizmos -
perfect opportunity for someone to extend and create a combined gizmo in
a follow-up :)

## Testing

- Manually tested with cargo run --example transform_gizmo --features
free_camera:
  - All three modes (translate, rotate, scale) work
  - Focus switch between objects, and gizmo moves across
  - World/local space toggle and editing
- Tested on Linux (X11)

## Showcase

Mark any entity with `TransformGizmoFocus` to get interactive handles:

```rust
app.add_plugins(TransformGizmoPlugin);

commands.spawn((
    Mesh3d(mesh),
    MeshMaterial3d(material),
    TransformGizmoFocus,
));
 

// Switch modes via resource
mode.set(TransformGizmoMode::Rotate);
```

The `transform_gizmo` example shows input cycling and keyboard mode
switching (1/2/3 for translate/rotate/scale, X to toggle world/local
space)

## Video
### Jackdaw


https://github.com/user-attachments/assets/8193b3ed-ae9c-416d-9514-8fb4f42a1f90

### Transform Example



https://github.com/user-attachments/assets/fea22981-4e61-492e-918e-9791ddf5a00d

---------

Co-authored-by: Alice Cecile <alice.i.cecile@gmail.com>

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
