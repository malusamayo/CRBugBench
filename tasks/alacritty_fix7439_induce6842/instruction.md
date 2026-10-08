# Code Review Task

You are a maintainer reviewing a pull request to the `alacritty/alacritty` repository.

**PR title:** Update to the new winit keyboard API

**PR description / commit message:**

Update to the new winit keyboard API

The main highlight of this update is that alacritty will now use new
keyboard API from the winit, which resolves a lot of issues around
key bindings, such as ability to bind dead keys. It also fixes long
standing issues with the virtual key code bindings and make bindings
in general more predictable. It also makes our default Vi key bindings
fully working.

Given that alacritty was using `VirtualKey` directly in the bindings
from the winit, and winit simply removed the enum, we've added internal
conversions to minimize the fallout, but new way to specify the bindings
should be more intuitive.

Other part of this update fixes some forward compatibility bugs with the
Wayland backend, given that wayland-rs 0.30 is fully forward compatible.
The update also fixes weird Maximized startup issues on GNOME Wayland,
however they were present on any sane compositor.

Fixes #6842.
Fixes #6455.
Fixes #6184.
Fixes #5684.
Fixes #3574.
Fixes #3460.
Fixes #1336.
Fixes #892.
Fixes #458.
Fixes #55.

## Working environment

The repository is checked out at `/app/alacritty` at this PR's **base commit**
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
