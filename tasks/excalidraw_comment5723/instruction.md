# Code Review Task

You are a maintainer reviewing a pull request to the `excalidraw/excalidraw` repository.

**PR title:** feat: Support labels for arrow 🔥

**PR description:**

for https://github.com/excalidraw/excalidraw/issues/5010

https://user-images.githubusercontent.com/11256141/192515552-6b6ddc06-5de0-4931-abdd-6ac3a804656d.mp4

TODOS
- [x] Make sure bound text takes exact dimensions
- [x] Support adding labels in arrow and lines for 2 pointer
- [x] Support adding in 2nd point for 3 pointer
- [x] Labels should move when text moves
- [x] Drag label when point dragged
- [x] support resizing
- [x] rotation
- [x] fix coords when updating text properties
- [x] Calculate position of bound text from original position after rotation
- [x] Move the linear elements when bound box hit and show move cursor as well when bound text hovered
- [x] Support rotation with multiple elements
- [x] Support resize with multiple elements
- [x] Delete bound text when all points deleted
- [x] Delete bound text when point attached to bound text deleted
- [x] Delete bound text when its segment deleted
- [x] Calculate bounding box correctly irrespective of rotation/bigger fonts
- [x] calculate bounding box correctly when text position updated by point movement
- [x] calculate dimensions for the container correctly when arrow upside down
- [x] Adjust text when dimensions changed for linear element
- [x] Consider text element angle when editing
- [x] show bounding box hit on bound text for 3 pointer
- [x] Move the bound text always to the mid point when number of points are odd
- [x] Move bound text always to mid segment mid point when points are even
- [x] Point should be visible on bound text inside editor
- [x] There are cases due to which the point doesn't render on correct segment when updated due to cache being incorrect- fixing this should fix resize overall when bound text rendered on segment
- [x] When pressing enter sometimes the text shows up in wrong position
- [x] Support adding text in multi point lines in center
- [x] Text should always be centered for multi points when typing
- [x] Introduce wrapping when resizing
- [x] Make export to SVG work
- [x] Mask the arrow / line where text is rendered in canvas
- [x] Fix masking during rotation in canvas
- [x] Fix masking when zooming in canvas
- [x] Fix masking in export preview
- [x] There is slight displacement of linear element in  export preview which gets more visible if you zoom in, change width/height and then export
- [x] Fix masking during rotation in svg
- [x] Allow double click
- [x] There are some edge cases where export preview is not rendering the linear element correctly. This is an intermediate issue and gets fixed automatically If I switch to some other element to export and come back to this.
<img width="342" alt="Screenshot 2022-11-03 at 3 23 58 PM" src="https://user-images.githubusercontent.com/11256141/199692224-3c0c67c0-56f1-43d5-964e-2ef035093735.png">
<img width="308" alt="Screenshot 2022-11-03 at 3 22 58 PM" src="https://user-images.githubusercontent.com/11256141/199692230-07fe41f1-541a-4c46-a710-6b7f22240331.png">

Pushed some improvements for this, hopefully should be fixed now
- [ ] Pasting a rotated linear element with labels sometimes doesn't respect the same center and pastes at some random positon. This is in prod as well, will fix in separate PR
- [x] When 2 pointer line is vertical, text cursor is not visible and width is too small
- [x] Add a threshold for minimum value till which 2 pointer arrow can be resized
- [x] Pasting long text doesn't set dimensions correctly - is in prod as well, will create a separate PR - https://github.com/excalidraw/excalidraw/pull/5845
- [x] When one arrow on top of another, it adds text to wrong arrow
 
https://user-images.githubusercontent.com/11256141/200820884-ab9594a3-7174-4a45-9d97-3fae271a2283.mp4

This is in prod too https://github.com/excalidraw/excalidraw/issues/5860, might fix in separate PR  https://github.com/excalidraw/excalidraw/pull/5880 to fix for all at once

- [x] Add padding
- [x] Hide vertical align as its not needed for arrow labels
- [x] Support labels only for arrows
- [x] Don't add midpoint until dragged to certain threshold - https://github.com/excalidraw/excalidraw/pull/5927
- [x] Enter line editor with cmd+double click
- [x] the cursor gets stuck when resizing over the midpoint -  https://github.com/excalidraw/excalidraw/pull/5723#issuecomment-1325755235
- [ ] Selecting arrow deselect it sometimes - https://github.com/excalidraw/excalidraw/pull/5723#issuecomment-1318365142 
- [x] Testing
- [x] Add tests

## Working environment

The repository is checked out at `/app/excalidraw` at this PR's **base commit**
(the state before this PR), and the proposed change is present two ways:

- applied as **uncommitted modifications** to the working tree (run `git diff`
  to see it, or use a review tool that inspects the local git diff), and
- saved as a unified diff at `/app/pr_to_review.diff`.

Use `git log` and `git show HEAD:<path>` (HEAD is the base commit) for
surrounding history, call sites, and conventions.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
