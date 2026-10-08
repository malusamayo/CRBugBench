#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `app/src/main/java/org/schabi/newpipe/player/PlayQueueActivity.java`:

This pull request introduces the defect later reported as "Back button in playlist while playing in foreground (maybe also background) kills app, reopening results in crash". The
problem a user observed, and its root cause:

### Checklist

- [X] I am able to reproduce the bug with the latest version given here: [CLICK THIS LINK](https://github.com/TeamNewPipe/NewPipe/releases/latest).
- [X] I made sure that there are *no existing issues* - [open](https://github.com/TeamNewPipe/NewPipe/issues) or [closed](https://github.com/TeamNewPipe/NewPipe/issues?q=is%3Aissue+is%3Aclosed) - which I could contribute my information to.
- [X] I have read the [FAQ](https://newpipe.net/FAQ/) and my problem isn't listed.
- [X] I have taken the time to fill in all the required details. I understand that the bug report will be dismissed otherwise.
- [X] This issue contains only one bug.
- [X] I have read and understood the [contribution guidelines](https://github.com/TeamNewPipe/NewPipe/blob/dev/.github/CONTRIBUTING.md).

### Affected version

0.25.2, from https://archive.newpipe.net/fdroid/repo?fingerprint=e2402c78f9b97c6c89e97db914a2751fda1d02fe2039cc0897a462bdb57e7501

### Steps to reproduce the bug

Here's what I did. It may not reproduce.

1. Queue up a big playlist in the background. I don't know if you also need to swipe the app off the switcher while it is playing.
2. Bring a video foreground.
3. Swipe it down to a small player, then open the playlist using the playlist icon there.
4. Rearrange the playlist a bit. (Probably not essential)
5. Press the back button. Pathologically, the app should close, ending playback and rubbishing your playlist, without a Guru Meditation. (Expected/Actual point 1)
6. Reopen the app from the app switcher.
7. This action should obtain a Guru Meditation (Expected/Actual point 2), which is probably a red herring.

### Expected behavior

1. I expected the back button to go back to the player without incident, or when backgrounded and swiped off, to go to desktop while continuing to play.
2. A Guru Meditation would not be produced if so.

### Actual behavior

1. The app closed, ending playback and rubbishing my playlist, without a guru meditation.
2. On reopening NewPipe, I got the attached red-herring Guru Meditation.

### Screenshots/Screen recordings

_No response_

### Logs

I hit the back button in the playlist display, and it killed my viewing session. I then opened Newpipe back up in the app switcher and got this crash.
## Exception
* __User Action:__ ui error
* __Request:__ ACRA report
* __Content Country:__ FR
* __Content Language:__ fr-FR
* __App Language:__ fr_FR
* __Service:__ none
* __Version:__ 0.25.2
* __OS:__ Linux Android 11 - 30
<details><summary><b>Crash log </b></summary><p>

```
java.lang.NullPointerException: Attempt to invoke virtual method 'org.schabi.newpipe.player.mediaitem.MediaItemTag org.schabi.newpipe.player.Player.getCurrentMetadata()' on a null object reference
	at org.schabi.newpipe.player.PlayQueueActivity.buildAudioTrackMenu(PlayQueueActivity.java:622)
	at org.schabi.newpipe.player.PlayQueueActivity.onCreateOptionsMenu(PlayQueueActivity.java:108)
	at android.app.Activity.onCreatePanelMenu(Activity.java:4206)
	at androidx.activity.ComponentActivity.onCreatePanelMenu(ComponentActivity.java:506)
	at androidx.fragment.app.FragmentActivity.onCreatePanelMenu(FragmentActivity.java:263)
	at androidx.appcompat.view.WindowCallbackWrapper.onCreatePanelMenu(WindowCallbackWrapper.java:95)
	at androidx.appcompat.app.AppCompatDelegateImpl$AppCompatWindowCallback.onCreatePanelMenu(AppCompatDelegateImpl.java:3122)
	at androidx.appcompat.app.ToolbarActionBar.populateOptionsMenu(ToolbarActionBar.java:458)
	at androidx.appcompat.app.ToolbarActionBar$1.run(ToolbarActionBar.java:58)
	at android.os.Handler.handleCallback(Handler.java:938)
	at android.os.Handler.dispatchMessage(Handler.java:99)
	at android.os.Looper.loop(Looper.java:223)
	at android.app.ActivityThread.main(ActivityThread.java:7660)
	at java.lang.reflect.Method.invoke(Native Method)
	at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:592)
	at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:947)

```
</details>
<hr>

### Affected Android/Custom ROM version

Android 11, LineageOS (unknown but I think 17)

### Affected device model

OnePlus 7 Pro (GM1915)

### Additional information

As a workaround, it could be interesting to add a function that autosaves the playing playlist, and restores it on start if it isn't empty or played-through. Somehow I suspect that'd be non-trivial however.

This same root cause must be fixed before merging.
REVIEW_EOF
