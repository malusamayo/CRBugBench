# Code Review Task

You are a maintainer reviewing a pull request to the `Stirling-Tools/Stirling-PDF` repository.

**PR title:** Fix drag and drop area for file choosers by adding separate ones (#2368)

**PR description / commit message:**

Fix drag and drop area for file choosers by adding separate ones (#2368)

* Add separate drag and drop area for file choosers

 - Add separate drag and drop area for file choosers

### Why?
Previously, when there were multiple file choosers in the same page, if you attempted to drag and drop any files, they would be added to both file choosers as it was designed at first to handle 1 file chooser present, now that we have multiple ones, it is necessary to adapt our design to match the changing functionality.

### Can you not preserve the old overlay when there's only one file chooser present?
Yes, we can, but imagine as a user, you try to drag and drop a file in one page and the fields turn into drag and drop areas then you go to another page and try to drag and drop again but you encounter the old overlay instead, as a user you might get confused and ask yourself "What changed?" or if a user is telling another user the steps to drag and drop files and he didn't know about this case, then it would still be confusing, thus consistency is preferred in this case.

* Update file chooser UI

* Add support for listing and removing selected files and their file icons

- Selected files are listed below the file chooser in a selected files container.
- Users can now remove uploaded/selected files.
- Hide selected files container/box unless there are files selected/uploaded.
- Add separate overlay for each drag & drop area.

## FAQ:
- Why did you assign a unique id to each file? isn't the filename enough?
= Because a user might upload multiple files with the same name, if the user wanted to remove one of them, how would we differentiate between them? we won't be able to unless we assign an identifier, you might argue "we remove based on the filename and size", then what if the user uploaded the same file more than once (intentionally), then we would accidentally remove all the files even though that is not what the user wanted, so going with unique ID approach would prevent this issue/problem from occurring in the first place.

* Rename remove-file css class to remove-selected-file

- Rename remove-file css class to remove-selected-file to avoid css conflict with remove-file in merge.css

* Use input element to dispatch event on file removal

Use the correct element to dispatch "file-input-change" (input element is the correct one).

* Adapt file chooser UI to themes

- Adapt file chooser UI to themes by adjusting their font colors and background colors.
- Make text more visible in overlay by increasing the font size by 0.1rem and setting font weight to 550.

* Remove extra overlay border

- Removing overlay's border as it is unnecessary and only causing a double border issue on the file input container.

* Remove Browse button, highlight file chooser and make it clickable

- Remove browse button.
- Make the entire file chooser container clickable.
- Add glowing effect on hover for file chooser.
- Change color of file chooser on hover.

* Replace crypto.randomUUID() with UUID.uuidv4()

- Replace crypto.randomUUID() with UUID.uuidv4() as crypto.randomUUID() is only supported in secured contexts such as localhost 127.0.0.1 and over HTTPS

* Fix merge file removal not being reflected in file chooser

- Files removed from the list in merge page would now be reflected in the file chooser's container.

* Make inputElement optional in removeFileById

- Make inputElement optional in removeFileById, this way we could control changing inputElements files.

* Add translation support to file chooser

---------

Co-authored-by: Anthony Stirling <77850077+Frooodle@users.noreply.github.com>

## Working environment

The repository is checked out at `/app/Stirling-PDF` at this PR's **base commit**
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
