#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `GitCommands/RevisionReader.cs`:

This pull request introduces the defect later reported as "[NBug] Specified argument was out of the range of valid values.". The
problem a user observed, and its root cause:

### Environment

- Git Extensions 4.2.0.17539
- Build d3b383c77a3cda85b835c7e6325c0ebb146a8be9
- Git 2.39.1.windows.1 (recommended: 2.41.0 or later)
- Microsoft Windows NT 10.0.19045.0
- .NET 6.0.23
- DPI 120dpi (125% scaling)
- Portable: False


### Issue description

```
System.ArgumentOutOfRangeException: Specified argument was out of the range of valid values.
   at void GitUI.RevisionGridControl.PerformRefreshRevisions(Func<RefsFilter, IReadOnlyList<IGitRef>> getRefs, bool forceRefresh)+() => { } in C:/projects/gitextensions/GitUI/UserControls/RevisionGrid/RevisionGridControl.cs:line 1333
   at async Task GitUI.TaskManager.HandleExceptionsAsync(Func<Task> asyncAction, Func<Exception, Task> handleExceptionAsync) in C:/projects/gitextensions/GitExtUtils/GitUI/TaskManager.cs:line 28
```

Open repository and log view crash


### Steps to reproduce

open big repository

### Did this work in previous version of GitExtensions?

_No response_

### Diagnostics

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
