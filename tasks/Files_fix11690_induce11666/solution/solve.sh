#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Files.App/Actions/Content/ImageEdition/RotateLeftAction.cs`:

This pull request introduces the defect later reported as "Bug: App crash when switching to another tab while items are selected". The
problem a user observed, and its root cause:

### Description

The app crashes if you selected a file and switched to another tab while the files are currently selected.

Works fine if you don't select anything before you switch tabs

### Steps To Reproduce

1. Open 2 or more tabs
2. Select a file
3. Switch to another tab

### Requirements

- Fix the crash

### Files Version

2.4.51.0

### Windows Version

10.0.22624.1391

### Log file

```
2023-03-13 02:15:53.0561|ERROR|AppUnhandledException|Object reference not set to an instance of an object.
	System.NullReferenceException: Object reference not set to an instance of an object.
   at Files.App.Actions.Content.ImageEdition.RotateLeftAction.Context_PropertyChanged(Object sender, PropertyChangedEventArgs e)
   at Files.App.Contexts.ContentPageContext.UpdateSelectedItems()
   at Files.App.Contexts.ContentPageContext.Update()
   at Files.App.Contexts.ContentPageContext.Context_Changed(Object sender, EventArgs e)
   at Files.App.UserControls.MultitaskingControl.BaseMultitaskingControl.MultitaskingControl_CurrentInstanceChanged(Object sender, CurrentInstanceChangedEventArgs e)
   at ABI.Microsoft.UI.Xaml.Controls.SelectionChangedEventHandler.Do_Abi_Invoke(IntPtr thisPtr, IntPtr sender, IntPtr e)
--- End of stack trace from previous location ---
   at WinRT.ExceptionHelpers.<ThrowExceptionForHR>g__Throw|20_0(Int32 hr)
   at ABI.Windows.ApplicationModel.Core.IUnhandledErrorMethods.Propagate(IObjectReference _obj)
   at Microsoft.AppCenter.Utils.ApplicationLifecycleHelperWinUI.<.ctor>b__0_3(Object sender, UnhandledErrorDetectedEventArgs eventArgs)
--- End of stack trace from previous location ---
   at Microsoft.AppCenter.Utils.ApplicationLifecycleHelperWinUI.<.ctor>b__0_3(Object sender, UnhandledErrorDetectedEventArgs eventArgs)
   at ABI.System.EventHandler`1.Do_Abi_Invoke[TAbi](Void* thisPtr, IntPtr sender, TAbi args)
   ```

This same root cause must be fixed before merging.
REVIEW_EOF
