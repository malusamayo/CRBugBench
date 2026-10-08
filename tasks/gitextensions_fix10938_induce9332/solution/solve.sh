#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `GitUI/UserControls/ConsoleEmulatorOutputControl.cs`:

This pull request introduces the defect later reported as "Console: font settings not working". The
problem a user observed, and its root cause:

### Environment

- Git Extensions 4.0.2.16100
- Build 25100ec1f7c8da8f798613da74826038af81a50e
- Git 2.39.0.windows.2
- Microsoft Windows NT 10.0.19044.0
- .NET 6.0.16
- DPI 96dpi (no scaling)
- Microsoft.WindowsDesktop.App Versions

```
    Microsoft.WindowsDesktop.App 3.1.25 [C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App]
    Microsoft.WindowsDesktop.App 3.1.32 [C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App]
    Microsoft.WindowsDesktop.App 6.0.16 [C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App]
```


### Issue description

I want to change the font size of the Console tab in Git Extensions 4.0.2.  I'm using xterm as console style.

When I go to Tools -> Settings  -> Git Extensions -> Appearance -> Console Style and change the font size (which defaults to Consolas, 10) to whatever value, the size of the font in the Console tab doesn't change after a restart.

### Steps to reproduce

Go to the Console Style section of the Settings, select xterm as console style and change the default font size to another value.  Then restart Git Extensions and go to the Console tab: font size is not changed.

### Did this work in previous version of GitExtensions?

Yes, versions 3 of Git Extensions

### Diagnostics

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
