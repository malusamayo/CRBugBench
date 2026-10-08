# Code Review Task

You are a maintainer reviewing a pull request to the `rustdesk/rustdesk` repository.

**PR title:** Feat: Wayland flatpak input support | Remote desktop portal (#6675)

**PR description / commit message:**

Feat: Wayland flatpak input support | Remote desktop portal (#6675)

* autogen portal code

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* use remote desktop portal

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* remove clipboard portal in favour of #6586

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* remove clipboard portal

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* use select_devices for input capture

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* remove embedded cursor code as not being used | return session path for input capture

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* setup rdp input

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* remove simulate example

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* setup rdp input raw key events + mouse movements

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* fix rdp raw key input

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* refact rdp raw key inpuy & fix right meta key

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* refact and support rdp layout mode key input

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* support rdp mouse clicks

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* support rdp mouse scroll

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* support rdp key sequence input

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* use rdp input only when uinput is not available

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* combine rdp input and get_capturables into a single rdp request

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* rdp fix build

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* rdp fix build

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* fix rdp caps lock

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* format pipewire.rs

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* format rdp_input.rs

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* revert #6628 as rdp request state is now managed (better solution)

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* fix rdp crash on arch kde

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* rdp_input.rs improvements

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* refact request_remote_desktop

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* improve unwraps

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* remove unwraps

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

* use session references instead of clones

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

---------

Signed-off-by: Sahil Yeole <sahilyeole93@gmail.com>

## Working environment

The repository is checked out at `/app/rustdesk` at this PR's **base commit**
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
