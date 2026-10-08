#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `app/src/main/java/org/schabi/newpipe/util/FilenameUtils.java`:

This pull request introduces the defect later reported as "Crashes while trying to download video with title including | or /". The
problem a user observed, and its root cause:

### Checklist

- [X] I am able to reproduce the bug with the latest version given here: [CLICK THIS LINK](https://github.com/TeamNewPipe/NewPipe/releases/latest).
- [X] I made sure that there are *no existing issues* - [open](https://github.com/TeamNewPipe/NewPipe/issues) or [closed](https://github.com/TeamNewPipe/NewPipe/issues?q=is%3Aissue+is%3Aclosed) - which I could contribute my information to.
- [X] I have read the [FAQ](https://newpipe.net/FAQ/) and my problem isn't listed.
- [X] I have taken the time to fill in all the required details. I understand that the bug report will be dismissed otherwise.
- [X] This issue contains only one bug.
- [X] I have read and understood the [contribution guidelines](https://github.com/TeamNewPipe/NewPipe/blob/dev/.github/CONTRIBUTING.md).

### Affected version

0.25.2

### Steps to reproduce the bug

1. Go to video including a "|" or "/" in its title. For example: https://www.youtube.com/watch?v=vzciMBhwkpc
2. Click the download symbol.

### Expected behavior

Start the download dialogue/window

### Actual behavior

The app crashes

### Screenshots/Screen recordings

_No response_

### Logs

```java
-------------------------------------
java.lang.IllegalArgumentException: Illegal group reference: group index is missing
	at java.util.regex.Matcher.appendEvaluated(Matcher.java:774)
	at java.util.regex.Matcher.appendReplacement(Matcher.java:717)
	at java.util.regex.Matcher.replaceAll(Matcher.java:843)
	at java.lang.String.replaceAll(String.java:2752)
	at org.schabi.newpipe.util.FilenameUtils.createFilename(FilenameUtils.java:67)
	at org.schabi.newpipe.util.FilenameUtils.createFilename(FilenameUtils.java:54)
	at org.schabi.newpipe.download.DownloadDialog.onViewCreated(DownloadDialog.java:308)
	at androidx.fragment.app.Fragment.performViewCreated(Fragment.java:3019)
	at androidx.fragment.app.FragmentStateManager.createView(FragmentStateManager.java:551)
	at androidx.fragment.app.FragmentStateManager.moveToExpectedState(FragmentStateManager.java:261)
	at androidx.fragment.app.FragmentManager.executeOpsTogether(FragmentManager.java:1840)
	at androidx.fragment.app.FragmentManager.removeRedundantOperationsAndExecute(FragmentManager.java:1764)
	at androidx.fragment.app.FragmentManager.execPendingActions(FragmentManager.java:1701)
	at androidx.fragment.app.FragmentManager$4.run(FragmentManager.java:488)
	at android.os.Handler.handleCallback(Handler.java:942)
	at android.os.Handler.dispatchMessage(Handler.java:99)
	at android.os.Looper.loopOnce(Looper.java:201)
	at android.os.Looper.loop(Looper.java:288)
	at android.app.ActivityThread.main(ActivityThread.java:7918)
	at java.lang.reflect.Method.invoke(Native Method)
	at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:548)
	at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:936)
------------------------------------- 
```

### Affected Android/Custom ROM version

Android 13

### Affected device model

Google Pixel 7 Pro

### Additional information

Downloading any video not including "|" or "/" in its title is still possible, as far as I can see.
Downloading said video on a "Huawei Y6s JAT-L41" with Android 9 is working.

This same root cause must be fixed before merging.
REVIEW_EOF
