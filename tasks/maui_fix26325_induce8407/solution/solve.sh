#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Core/src/Handlers/Picker/PickerHandler.Windows.cs`:

This pull request introduces the defect later reported as "Picker ItemsSource changed case exception: Value does not fall within the expected range". The
problem a user observed, and its root cause:

### Description

When the initial bound source elements of the picker are 4, and an item with an index of 3 is selected, changing the source elements of the picker to 2 will immediately result in an exception, indicating that "Value does not fall within the expected range."

Ideally, after switching the data source, the selectedIndex should revert to the default value of -1.

### Steps to Reproduce

_No response_

### Link to public reproduction project repository

_No response_

### Version with bug

9.0.0 GA

### Is this a regression from previous behavior?

Not sure, did not test other versions

### Last version that worked well

_No response_

### Affected platforms

Windows

### Affected platform versions

_No response_

### Did you find any workaround?

no

### Relevant log output

```shell

```

This same root cause must be fixed before merging.
REVIEW_EOF
