#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/main/java/io/reactivex/rxjava3/internal/schedulers/ExecutorScheduler.java`:

This pull request introduces the defect later reported as "[3.x] `ScheduledRunnable` does not respect `ExecutorScheduler.interruptibleWorker`". The
problem a user observed, and its root cause:

Version: 3.1.8

`ExecutorScheduler` uses `ScheduledRunnable` for Scheduled tasks with delay. Disposing `ScheduledRunnable` cancels the set `Future` here:
https://github.com/ReactiveX/RxJava/blob/3.x/src/main/java/io/reactivex/rxjava3/internal/schedulers/ScheduledRunnable.java#L117
In case you're disposing it from a different thread, `mayInterruptIfRunning` will be set to `true` when disposing contrary to `ExecutorScheduler#interruptibleWorker` value.
Essentially, if you do `Schedulers.from(executor, interruptibleWorker = false)`, you'll have uncleared `interrupted` flag set to your thread in _some_ cases.

Consider this example:

```
//Creating an executor that throws if attempting to send an interruptible cancel 
private class ThrowOnInterruptExecutor : ScheduledThreadPoolExecutor(10) {

    override fun <V : Any?> schedule(callable: Callable<V>?, delay: Long, unit: TimeUnit?): ScheduledFuture<V> {
        return CrashOnInterruptFuture(super.schedule(callable, delay, unit))
    }

    class CrashOnInterruptFuture<T>(
        private val delegate: ScheduledFuture<T>
    ) : ScheduledFuture<T> by delegate {

        override fun cancel(mayInterruptIfRunning: Boolean): Boolean {
            return if (mayInterruptIfRunning) {
                throw IllegalStateException("Attempt to interrupt!")
            } else {
                delegate.cancel(mayInterruptIfRunning)
            }
        }
    }
}

fun main() {
    val scheduler = Schedulers.from(ThrowOnInterruptExecutor())
    val worker = scheduler.createWorker()
    val d = worker.schedule({    }, 1, TimeUnit.SECONDS)
    d.dispose()
}
```

We'll get
```
Exception in thread "main" java.lang.IllegalStateException: Attempt to interrupt!
	at ThrowOnInterruptExecutor$CrashOnInterruptFuture.cancel(Test.kt:16)
	at io.reactivex.rxjava3.internal.schedulers.ScheduledRunnable.dispose(ScheduledRunnable.java:117)
	at io.reactivex.rxjava3.internal.disposables.DisposableHelper.dispose(DisposableHelper.java:124)
	at io.reactivex.rxjava3.internal.disposables.SequentialDisposable.dispose(SequentialDisposable.java:72)
	at io.reactivex.rxjava3.internal.disposables.DisposableHelper.dispose(DisposableHelper.java:124)
	at io.reactivex.rxjava3.internal.disposables.SequentialDisposable.dispose(SequentialDisposable.java:72)
```

Even though the task didn't start yet, we still make an attempt to interrupt. In production i see crashes related to uncleared interrupted flag, which are caused by this. 

Should `ScheduledRunnable` accept `interruptible` flag and call `cancel(interruptibleWorker && async)` upon dispose instead?
Thanks.

This same root cause must be fixed before merging.
REVIEW_EOF
