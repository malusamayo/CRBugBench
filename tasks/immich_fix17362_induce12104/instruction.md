# Code Review Task

You are a maintainer reviewing a pull request to the `immich-app/immich` repository.

**PR title:** feat(mobile): native_video_player (#12104)

**PR description / commit message:**

feat(mobile): native_video_player (#12104)

* add native player library

* splitup the player

* stateful widget

* refactor: native_video_player

* fix: handle buffering

* turn on volume when video plays

* fix: aspect ratio

* fix: handle remote asset orientation

* refinements and fixes

fix orientation for remote assets

wip separate widget

separate video loader widget

fixed memory leak

optimized seeking, cleanup

debug context pop

use global key

back to one widget

fixed rebuild

wait for swipe animation to finish

smooth hero animation for remote videos

faster scroll animation

* clean up logging

* refactor aspect ratio calculation

* removed unnecessary import

* transitive dependencies

* fixed referencing uninitialized orientation

* use correct ref to build android

* higher res placeholder for local videos

* slightly lower delay

* await things

* fix controls when swiping between image and video

* linting

* extra smooth seeking, add comments

* chore: generate router page

* use current asset provider and loadAsset

* fix stack handling

* improved motion photo handling

* use visibility for motion videos

* error handling for async calls

* fix duplicate key error

* maybe fix duplicate key error

* increase delay for hero animation

* faster initialization for remote videos

* ensure dimensions for memory cards

* make aspect ratio logic reusable, optimizations

* refactor: move exif search from aspect ratio to orientation

* local orientation on ios is unreliable; prefer remote

* fix no audio in silent mode on ios

* increase bottom bar opacity to account for hdr

* remove unused import

* fix live photo play button not updating

* fix map marker -> galleryviewer

* remove video_player

* fix hdr playback on android

* fix looping

* remove unused dependencies

* update to latest player commit

* fix player controls hiding when video is not playing

* fix restart video

* stop showing motion video after ending when looping is disabled

* delay video initialization to avoid placeholder flicker

* faster animation

* shorter delay

* small delay for image -> video on android

* fix: lint

* hide stacked children when controls are hidden, avoid bottom bar dropping

---------

Co-authored-by: Alex <alex.tran1502@gmail.com>
Co-authored-by: shenlong-tanwen <139912620+shalong-tanwen@users.noreply.github.com>
Co-authored-by: mertalev <101130780+mertalev@users.noreply.github.com>

## Working environment

The repository is checked out at `/app/immich` at this PR's **base commit**
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
