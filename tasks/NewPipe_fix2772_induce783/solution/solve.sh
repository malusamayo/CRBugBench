#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `app/src/main/java/org/schabi/newpipe/player/PopupVideoPlayer.java`:

This pull request introduces the defect later reported as "exception after closing popup". The
problem a user observed, and its root cause:

- [x] I carefully read the [contribution guidelines](https://github.com/TeamNewPipe/NewPipe/blob/HEAD/.github/CONTRIBUTING.md) and agree to them.
- [x] I checked if the issue/feature exists in the latest version.
- [x] I did use the [incredible bugreport to markdown converter](https://teamnewpipe.github.io/CrashReportToMarkdown/) to paste bug reports.

I get an exception when I try to close a popup video.

Steps to reproduce: 
0: start a video playback in popup mode
1: tap down on the video to make the close button appear
2: while you're still tapping on the video press the close button simultaneously
3: an exception will occur

I think the issue is that new pipe thinks I'm trying to resize the window but I'm just trying to close the popup video. Unfortunatley the close button disappears too quickly for me so I have to keep tapping on the popup window. It would be cool if the time it takes for the close button to disappear could be extended.

Stack trace:
## Exception
* __User Action:__ ui error
* __Request:__ App crash, UI failure
* __Content Language:__ GB
* __Service:__ none
* __Version:__ 0.14.1
* __OS:__ Linux Android 8.0.0 - 26

```
java.lang.NullPointerException: Attempt to invoke virtual method 'android.widget.TextView org.schabi.newpipe.player.PopupVideoPlayer$VideoPlayerImpl.getResizingIndicator()' on a null object reference
	at org.schabi.newpipe.player.PopupVideoPlayer$PopupWindowGestureListener.onTouch(PopupVideoPlayer.java:1070)
	at android.view.View.dispatchTouchEvent(View.java:12536)
	at android.view.ViewGroup.dispatchTransformedTouchEvent(ViewGroup.java:3153)
	at android.view.ViewGroup.dispatchTouchEvent(ViewGroup.java:2829)
	at android.view.View.dispatchPointerEvent(View.java:12788)
	at android.view.ViewRootImpl$ViewPostImeInputStage.processPointerEvent(ViewRootImpl.java:5670)
	at android.view.ViewRootImpl$ViewPostImeInputStage.onProcess(ViewRootImpl.java:5465)
	at android.view.ViewRootImpl$InputStage.deliver(ViewRootImpl.java:4958)
	at android.view.ViewRootImpl$InputStage.onDeliverToNext(ViewRootImpl.java:5011)
	at android.view.ViewRootImpl$InputStage.forward(ViewRootImpl.java:4977)
	at android.view.ViewRootImpl$AsyncInputStage.forward(ViewRootImpl.java:5114)
	at android.view.ViewRootImpl$InputStage.apply(ViewRootImpl.java:4985)
	at android.view.ViewRootImpl$AsyncInputStage.apply(ViewRootImpl.java:5171)
	at android.view.ViewRootImpl$InputStage.deliver(ViewRootImpl.java:4958)
	at android.view.ViewRootImpl$InputStage.onDeliverToNext(ViewRootImpl.java:5011)
	at android.view.ViewRootImpl$InputStage.forward(ViewRootImpl.java:4977)
	at android.view.ViewRootImpl$InputStage.apply(ViewRootImpl.java:4985)
	at android.view.ViewRootImpl$InputStage.deliver(ViewRootImpl.java:4958)
	at android.view.ViewRootImpl.deliverInputEvent(ViewRootImpl.java:7736)
	at android.view.ViewRootImpl.doProcessInputEvents(ViewRootImpl.java:7676)
	at android.view.ViewRootImpl.enqueueInputEvent(ViewRootImpl.java:7637)
	at android.view.ViewRootImpl$WindowInputEventReceiver.onInputEvent(ViewRootImpl.java:7847)
	at android.view.InputEventReceiver.dispatchInputEvent(InputEventReceiver.java:197)
	at android.os.MessageQueue.nativePollOnce(Native Method)
	at android.os.MessageQueue.next(MessageQueue.java:325)
	at android.os.Looper.loop(Looper.java:142)
	at android.app.ActivityThread.main(ActivityThread.java:6944)
	at java.lang.reflect.Method.invoke(Native Method)
	at com.android.internal.os.Zygote$MethodAndArgsCaller.run(Zygote.java:327)
	at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:1374)

-------------------

```

edit: this could be related to https://github.com/TeamNewPipe/NewPipe/issues/1707 (or even be the same issue) but the stack trace looked different so I posted it as new issue.

This same root cause must be fixed before merging.
REVIEW_EOF
