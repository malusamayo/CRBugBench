#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Assets/build/Microsoft.AspNetCore.App.Internal.Assets.targets`:

This pull request introduces the defect later reported as "blazor.web.js and blazor.server.js request return 404 when Project OutputType is WinExe". The
problem a user observed, and its root cause:

### Is there an existing issue for this?

- [x] I have searched the existing issues

### Describe the bug

Our team has internally built and is using a tooling application with .NET 8.0 and Blazor. Because the app needs to run in the background on each individual’s Windows machine, we set the OutputType to WinExe.

With the release of .NET version 10.0, we started upgrading the app, but every page was rendering as a blank page. We tried various solutions we found, but none had any effect.

However, after removing the `<OutputType>WinExe</OutputType>` option from the .csproj—an option we had assumed would be harmless—and testing again, the pages began displaying correctly.

### Expected Behavior

_No response_

### Steps To Reproduce

_No response_

### Exceptions (if any)

_No response_

### .NET Version

_No response_

### Anything else?

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
