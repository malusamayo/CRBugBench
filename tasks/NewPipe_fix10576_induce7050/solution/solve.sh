#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `app/src/main/java/org/schabi/newpipe/local/feed/FeedFragment.kt`:

This pull request introduces the defect later reported as "App Crash II". The
problem a user observed, and its root cause:

### Checklist

- [X] I am able to reproduce the bug with the [latest version](https://github.com/TeamNewPipe/NewPipe/releases/latest).
- [X] I made sure that there are *no existing issues* - [open](https://github.com/TeamNewPipe/NewPipe/issues) or [closed](https://github.com/TeamNewPipe/NewPipe/issues?q=is%3Aissue+is%3Aclosed) - which I could contribute my information to.
- [X] I have read the [FAQ](https://newpipe.net/FAQ/) and my problem isn't listed.
- [X] I have taken the time to fill in all the required details. I understand that the bug report will be dismissed otherwise.
- [X] This issue contains only one bug.
- [X] I have read and understood the [contribution guidelines](https://github.com/TeamNewPipe/NewPipe/blob/dev/.github/CONTRIBUTING.md).

### Affected version

0.24.0

### Steps to reproduce the bug

Try to rotate the phone can cause crash. It appears to be not responding caused by a commit error.

### Expected behavior

Expect no lags for rotating the phone to not having lags.

### Actual behavior

This caused to having lags and made unresponsive for rotation. Their commit made memory dumps and will not run on this stock OS memory. @Stypox must be fixed their unresponsive rotating error.

### Screenshots/Screen recordings

See crash logs.

### Logs

## Exception
* __User Action:__ ui error
* __Request:__ ACRA report
* __Content Country:__ PH
* __Content Language:__ en-PH
* __App Language:__ en_PH
* __Service:__ none
* __Version:__ 0.24.0
* __OS:__ Linux Android 12 - 31
<details><summary><b>Crash log </b></summary><p>

```
java.lang.NullPointerException: Attempt to invoke virtual method 'android.content.ContentResolver android.content.Context.getContentResolver()' on a null object reference
	at org.schabi.newpipe.util.DeviceUtils.hasAnimationsAnimatorDurationEnabled(DeviceUtils.java:153)
	at org.schabi.newpipe.local.feed.FeedFragment.showNewItemsLoaded$lambda-23(FeedFragment.kt:625)
	at org.schabi.newpipe.local.feed.FeedFragment.$r8$lambda$MVUQe28qoMVGUV7lYJw3HduSzm4(Unknown Source:0)
	at org.schabi.newpipe.local.feed.FeedFragment$$ExternalSyntheticLambda12.run(Unknown Source:2)
	at org.schabi.newpipe.ktx.ExecOnEndListener.onAnimationEnd(View.kt:279)
	at android.view.ViewPropertyAnimator$AnimatorEventListener.onAnimationEnd(ViewPropertyAnimator.java:1116)
	at android.animation.Animator$AnimatorListener.onAnimationEnd(Animator.java:563)
	at android.animation.ValueAnimator.endAnimation(ValueAnimator.java:1250)
	at android.animation.ValueAnimator.doAnimationFrame(ValueAnimator.java:1505)
	at android.animation.AnimationHandler.doAnimationFrame(AnimationHandler.java:146)
	at android.animation.AnimationHandler.access$100(AnimationHandler.java:37)
	at android.animation.AnimationHandler$1.doFrame(AnimationHandler.java:54)
	at android.view.Choreographer$CallbackRecord.run(Choreographer.java:1240)
	at android.view.Choreographer.doCallbacks(Choreographer.java:996)
	at android.view.ChoreographerExtImpl.checkScrollOptSceneEnable(ChoreographerExtImpl.java:374)
	at android.view.Choreographer.doFrame(Choreographer.java:865)
	at android.view.Choreographer$FrameDisplayEventReceiver.run(Choreographer.java:1227)
	at android.os.Handler.handleCallback(Handler.java:938)
	at android.os.Handler.dispatchMessage(Handler.java:99)
	at android.os.Looper.loopOnce(Looper.java:233)
	at android.os.Looper.loop(Looper.java:344)
	at android.app.ActivityThread.main(ActivityThread.java:8248)
	at java.lang.reflect.Method.invoke(Native Method)
	at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:589)
	at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:1071)

```
</details>
<hr>


### Affected Android/Custom ROM version

Android 12 [Global India ROM, realme UI 3.0]

### Affected device model

realme 8 4G

### Additional information

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
