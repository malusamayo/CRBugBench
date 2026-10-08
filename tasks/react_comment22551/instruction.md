# Code Review Task

You are a maintainer reviewing a pull request to the `react/react` repository.

**PR title:** Allow to use the Profiler when no client is connected in standalone DevTools

**PR description:**

## Summary

Allows the Profiler tab to be used without the need of having a connected client in the DevTools standalone version (issue: #22127). The option to open the Profiler was added to the introduction/greeting page and redirects the user to the DevTools component. The impact in the DevTools component is minimum since no changes were made directly to it, only the react-devtools-core and the splash page were modified.
As I mentioned in the issue discussion, a fake Bridge and Store were created in order to render the DevTools, there might exist a better workaround and should be reviewed.
Also, the idea was to open the Profiler tab by default, but there are two props that can affect that behaviour: overrideTab (which prevents the tab from being changed because it is constantly overridden) and defaultTab (which sets the initial value for the LocalStorage entry that contains the tab that is open, but if a value is already stored in the LocalStorage, it is returned and the defaultValue is not used). It means that to change that behaviour it would be necessary to add an extra prop to the DevTools component and change the way the opened tab is selected at first.

## How did you test this change?
It was tested by building and running the DevTools with the changes made.
The instruction splash page would look like this:
<img width="912" alt="Screen Shot 2021-10-13 at 12 49 27 PM" src="https://user-images.githubusercontent.com/39140902/137186324-3754e85c-80db-40dd-a1fe-e1fdfc5eaddb.png">
After pressing the "Profiler tab" link, it redirects the user to the DevTools:
<img width="912" alt="Screen Shot 2021-10-13 at 12 50 58 PM" src="https://user-images.githubusercontent.com/39140902/137186519-b994e69a-cc92-46da-a672-31838a3538b9.png">
If a user loads a saved profile, the profiler can be used as usual:
<img width="912" alt="Screen Shot 2021-10-13 at 12 51 40 PM" src="https://user-images.githubusercontent.com/39140902/137186613-0b21233d-1258-4983-82dc-33e7d678a3ac.png">
And when a connection is established with a client it updates and show the component tree and allows the profiler to record activity:
![Screen Shot 2021-10-13 at 2 05 24 PM](https://user-images.githubusercontent.com/39140902/137197302-8f69dd34-01cf-4a93-9063-b07f36afdcad.png)

## Working environment

The repository is checked out at `/app/react` at this PR's **base commit**
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
