# Code Review Task

You are a maintainer reviewing a pull request to the `JabRef/jabref` repository.

**PR title:** Implement task progress indicator (and dialog) in the toolbar (#6443)

**PR description / commit message:**

Implement task progress indicator (and dialog) in the toolbar (#6443)

* First draft of a task progress dialog

Implemented a task progress dialog using a TaskProgressView.
Tasks show up, but without info. Neither the progress nor title and
message are shown.

* Added progress indicator in JabRefFrame

There now i a progress indicator at the rightmost postition of JabRefs
toolbar. It shows the average progress of all running background tasks.
Clicking it will show a TaskProgressDialog.

still looks ugly and the binding to the average progress does not seem
to be working.

* Beautified progressindicator and added localization

* Changed to Task<?> in the Tasklist.

This makes the view work with download tasks for example. Most other
tasks are still shown without title, message (because none are set) and
progress.
Also, there are a lot of tasks somehow.

The progress indicator in the main view still does not work as I can't
get the bindings to work.

* Resolved typing issues for bindings

The progress indicator is now successfully bound to the list of tasks.
However, tasks do not show up in the dialogue any more.

* Converted list of Properties to tasks for listbind

When using ObjectProperties in the list of tasks, we can use EasyBind to
convert the list into a list of tasks which in turn can be bound to the
list of tasks in the view.

With this, the basic functionality works. There is a progress indicator
in the toolbar that shows the average progress of all running background
tasks. It is indeterminate if any task has indeterminate progress and
shows 100% if no tasks are running.

Clicking it opens an overview of all running tasks and their progress.

Currently, there are many tasks running all the time. The only tasks
that were adapted for this to be pretty are the download tasks, and they
are also still missing an icon.

* New Tasks are first in the list

* Use a PopOver instead of a dialog

* Only show download tasks

* Better messages for download tasks

These are shorter and therefore the task progress view does not need a
horizontal scroll bar.

* Type Witnesses are not needed any more.

* Added extractor to task list

* Made anyTaskRunningBinding public

For consistency with other variables

* Removed ObjectProperty wrapping

* NOT WORKING: quit dialogue

* Cleanup

* Fix in dialog service

Make showProgressDialogAndWait actually not only show but also wait.

* Add extractor for isRunning

* More informative (and working) quit dialog

The dialog that is shown when the user quits JabRef during ongoing
background tasks now shows which background tasks are still running.

When all of them complete or the user chooses to quit anyway, JabRef
quits.

The user can also cancel the dialog. In that case, the dialog closes and
JobRef remains running.

* Added graphics callback

* Fixed some style issues

There are still some ImportOrder errors though where I can see no issue.

* Registered the save task as background task

This makes the dialog that pops up if background tasks are running wait
for pending saves.

* Revert "Registered the save task as background task"

This reverts commit d7442cc2247772b6e54bcb68cea947a5a2a604bc.

* Added note on dialog-order upon close

* Updated changelog

* Fixed style

* Quickfix for resizing indicator when indeterminate

Set the pref-width when the indicator is determinate to keep the
indeterminate state from making the indicator wider.

* Styled dialog waiting for background tasks

* Minor style fix

* Removed Globals from DefaultTaskExecutor

Addresses https://github.com/JabRef/jabref/pull/6443#discussion_r422981410

* Removed WaitForBackgroundtasksFinishedDialog

More in line with the other JabRef dialogs
Addresses https://github.com/JabRef/jabref/pull/6443#discussion_r422977336

* Made Bindings in StateManager private

Addresses https://github.com/JabRef/jabref/pull/6443#discussion_r422975104

* Added tooltip to progress indicator

Addresses https://github.com/JabRef/jabref/pull/6443#discussion_r422973356

* Not working: own styleclass for toolbar progress indicator

Tries to address https://github.com/JabRef/jabref/pull/6443#discussion_r422971198

* Changed callback to method in BackgroundTask

Addresses https://github.com/JabRef/jabref/pull/6443#discussion_r422980468

* Fixed progress-indicator styling

* Improve getIcon method

* Well, I said hopefully ;-)

* Revert "Well, I said hopefully ;-)"

This reverts commit 0557c678a657e6315dcb2c2c1c98d90b45a76e08.

* Revert "Improve getIcon method"

This reverts commit 478ee059e5606251361d663b939284f19bc834e4.

* Improved readability in JabRefFrame

Co-authored-by: Benedikt Tutzer <benedikt.tutzer@gmail.com>
Co-authored-by: Tobias Diez <tobiasdiez@gmx.de>

## Working environment

The repository is checked out at `/app/jabref` at this PR's **base commit**
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
