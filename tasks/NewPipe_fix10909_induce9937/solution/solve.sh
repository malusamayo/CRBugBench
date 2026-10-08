#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `app/src/main/java/org/schabi/newpipe/util/ListHelper.java`:

This pull request introduces the defect later reported as "Crash when trying to play/download some streams (failure to sort streams)". The
problem a user observed, and its root cause:

### Checklist

- [X] I am able to reproduce the bug with the latest version given here: [CLICK THIS LINK](https://github.com/TeamNewPipe/NewPipe/releases/latest).
- [X] I made sure that there are *no existing issues* - [open](https://github.com/TeamNewPipe/NewPipe/issues) or [closed](https://github.com/TeamNewPipe/NewPipe/issues?q=is%3Aissue+is%3Aclosed) - which I could contribute my information to.
- [X] I have read the [FAQ](https://newpipe.net/FAQ/) and my problem isn't listed.
- [X] I have taken the time to fill in all the required details. I understand that the bug report will be dismissed otherwise.
- [X] This issue contains only one bug.
- [X] I have read and understood the [contribution guidelines](https://github.com/TeamNewPipe/NewPipe/blob/dev/.github/CONTRIBUTING.md).

### Affected version

0.26.1

### Steps to reproduce the bug

1. Try to play Mr. Beast's latest video: https://www.youtube.com/watch?v=mKdjycj-7eE
2. As soon as you press play, an error occurs. The video does not play.  Video does not appear to buffer before playing, the crash is instantaneous.

### Expected behavior

Video should play.

### Actual behavior

Error notification, three "error occurred" toasts display, one after another.

### Screenshots/Screen recordings

_No response_

### Logs

## Exception
* __User Action:__ play stream
* __Request:__ Loading failed for [Protect The Lamborghini, Keep It!]: https://www.youtube.com/watch?v=mKdjycj-7eE
* __Content Country:__ US
* __Content Language:__ en-
* __App Language:__ en_US
* __Service:__ YouTube
* __Version:__ 0.26.1
* __OS:__ Linux Android 12 - 32
<details><summary><b>Crash log </b></summary><p>

```
java.lang.Exception: java.lang.NullPointerException: Attempt to invoke virtual method 'java.lang.Class java.lang.Object.getClass()' on a null object reference
	at org.schabi.newpipe.player.playback.MediaSourceManager.lambda$getLoadedMediaSource$7(MediaSourceManager.java:454)
	at org.schabi.newpipe.player.playback.MediaSourceManager.$r8$lambda$7wkrzYpwfZdms79okpk8_MCaW4U(MediaSourceManager.java:0)
	at org.schabi.newpipe.player.playback.MediaSourceManager$$ExternalSyntheticLambda5.apply(R8$$SyntheticClass:0)
	at io.reactivex.rxjava3.internal.operators.single.SingleOnErrorReturn$OnErrorReturn.onError(SingleOnErrorReturn.java:55)
	at io.reactivex.rxjava3.internal.operators.single.SingleMap$MapSingleObserver.onError(SingleMap.java:70)
	at io.reactivex.rxjava3.internal.operators.single.SingleMap$MapSingleObserver.onSuccess(SingleMap.java:61)
	at io.reactivex.rxjava3.internal.operators.single.SingleDoOnError$DoOnError.onSuccess(SingleDoOnError.java:52)
	at io.reactivex.rxjava3.internal.operators.single.SingleSubscribeOn$SubscribeOnObserver.onSuccess(SingleSubscribeOn.java:68)
	at io.reactivex.rxjava3.internal.operators.maybe.MaybeToSingle$ToSingleMaybeSubscriber.onSuccess(MaybeToSingle.java:83)
	at io.reactivex.rxjava3.internal.operators.flowable.FlowableElementAtMaybe$ElementAtSubscriber.onNext(FlowableElementAtMaybe.java:80)
	at io.reactivex.rxjava3.internal.operators.maybe.MaybeConcatArray$ConcatMaybeObserver.drain(MaybeConcatArray.java:136)
	at io.reactivex.rxjava3.internal.operators.maybe.MaybeConcatArray$ConcatMaybeObserver.request(MaybeConcatArray.java:78)
	at io.reactivex.rxjava3.internal.operators.flowable.FlowableElementAtMaybe$ElementAtSubscriber.onSubscribe(FlowableElementAtMaybe.java:66)
	at io.reactivex.rxjava3.internal.operators.maybe.MaybeConcatArray.subscribeActual(MaybeConcatArray.java:42)
	at io.reactivex.rxjava3.core.Flowable.subscribe(Flowable.java:16013)
	at io.reactivex.rxjava3.internal.operators.flowable.FlowableElementAtMaybe.subscribeActual(FlowableElementAtMaybe.java:36)
	at io.reactivex.rxjava3.core.Maybe.subscribe(Maybe.java:5377)
	at io.reactivex.rxjava3.internal.operators.maybe.MaybeToSingle.subscribeActual(MaybeToSingle.java:46)
	at io.reactivex.rxjava3.core.Single.subscribe(Single.java:4855)
	at io.reactivex.rxjava3.internal.operators.single.SingleSubscribeOn$SubscribeOnObserver.run(SingleSubscribeOn.java:89)
	at io.reactivex.rxjava3.core.Scheduler$DisposeTask.run(Scheduler.java:644)
	at io.reactivex.rxjava3.internal.schedulers.ScheduledRunnable.run(ScheduledRunnable.java:65)
	at io.reactivex.rxjava3.internal.schedulers.ScheduledRunnable.call(ScheduledRunnable.java:56)
	at java.util.concurrent.FutureTask.run(FutureTask.java:266)
	at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run(ScheduledThreadPoolExecutor.java:301)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1167)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:641)
	at java.lang.Thread.run(Thread.java:920)
Caused by: java.lang.NullPointerException: Attempt to invoke virtual method 'java.lang.Class java.lang.Object.getClass()' on a null object reference
	at java.lang.Enum.compareTo(Enum.java:184)
	at java.lang.Enum.compareTo(Enum.java:61)
	at j$.util.Comparator$-CC.lambda$comparing$77a9974f$1(Unknown Source:10)
	at j$.util.Comparator$$ExternalSyntheticLambda5.compare(Unknown Source:2)
	at j$.util.Comparator$-CC.$private$lambda$thenComparing$36697e65$1(Unknown Source:7)
	at j$.util.Comparator$$ExternalSyntheticLambda1.compare(Unknown Source:4)
	at java.util.TimSort.binarySort(TimSort.java:296)
	at java.util.TimSort.sort(TimSort.java:221)
	at java.util.Arrays.sort(Arrays.java:1492)
	at j$.util.stream.SortedOps$SizedRefSortingSink.end(Unknown Source:7)
	at j$.util.stream.AbstractPipeline.copyInto(Unknown Source:25)
	at j$.util.stream.AbstractPipeline.wrapAndCopyInto(Unknown Source:10)
	at j$.util.stream.ReduceOps$ReduceOp.evaluateSequential(Unknown Source:4)
	at j$.util.stream.AbstractPipeline.evaluate(Unknown Source:34)
	at j$.util.stream.ReferencePipeline.collect(Unknown Source:61)
	at org.schabi.newpipe.util.ListHelper.getFilteredAudioStreams(ListHelper.java:324)
	at org.schabi.newpipe.player.resolver.VideoPlaybackResolver.resolve(VideoPlaybackResolver.java:81)
	at org.schabi.newpipe.player.Player.sourceOf(Player.java:1911)
	at org.schabi.newpipe.player.playback.MediaSourceManager.lambda$getLoadedMediaSource$6(MediaSourceManager.java:425)
	at org.schabi.newpipe.player.playback.MediaSourceManager.$r8$lambda$TrlxO9KUeHA8dnLgSgaWsUWa_Ko(MediaSourceManager.java:0)
	at org.schabi.newpipe.player.playback.MediaSourceManager$$ExternalSyntheticLambda4.apply(R8$$SyntheticClass:0)
	at io.reactivex.rxjava3.internal.operators.single.SingleMap$MapSingleObserver.onSuccess(SingleMap.java:58)
	... 22 more

```
</details>
<hr>


### Affected Android/Custom ROM version

Android 12 (LineageOS)

### Affected device model

Moto Z3 Play

### Additional information

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
