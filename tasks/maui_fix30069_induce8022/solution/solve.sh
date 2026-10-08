#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Controls/src/Core/Compatibility/Handlers/Shell/Android/ShellFlyoutTemplatedContentRenderer.cs`:

This pull request introduces the defect later reported as "[Android] OnSizeAllocated not reported for Android AppShell Flyout content". The
problem a user observed, and its root cause:

### Description

Correct width and height not being reported for a content view that is placed inside of AppShell FlyoutContent

### Steps to Reproduce

1. Create a new MAUI App
2. Change FlyoutBehavior to "Flyout"
3. Add a Custom ContentView and override OnSizeAllocated method
 protected override void OnSizeAllocated(double width, double height)
 {
     base.OnSizeAllocated(width, height);
     // BUG: Actual size never reported :(
     Console.WriteLine($"====> W {width} H {height}");
 }
4. Add the custom content view as a flyout in appshell
 <Shell.FlyoutContent>
     <local:MainMenuView />
 </Shell.FlyoutContent>

When running the app the method is invoked twice 
once with '-1' values and another time with '0' values - never the actual size.

### Link to public reproduction project repository

_No response_

### Version with bug

8.0.21 SR4.1

### Is this a regression from previous behavior?

Not sure, did not test other versions

### Last version that worked well

Unknown/Other

### Affected platforms

Android

### Affected platform versions

API 33 tested

### Did you find any workaround?

nope

### Relevant log output

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
