#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `common/src/main/java/io/netty/util/concurrent/AbstractScheduledEventExecutor.java`:

This pull request introduces the defect later reported as "Scheduled future executions fail w/ NPEs". The
problem a user observed, and its root cause:

I've setup a unit test in my code, which eventually submits a lot of tasks via Vert.X, which eventually calls `io.netty.util.concurrent.EventExecutorGroup#scheduleAtFixedRate`.

## Reproducer (using Vert.X)

One set of dependency versions causing failures are:
* io.vertx:*:4.5.14
* io.netty:*:4.1.118.Final

Another set of dependency versions causing _different_ exceptions are:
* io.vertx:*:4.5.16
* io.netty:*:4.1.121.Final

The test _passes_ with:
* io.vertx:*:5.0.1
* io.netty:*:4.2.2.Final

The reproducer is mostly boilerplate to submit tasks concurrently and repeatedly.

The "key parts" to trigger the exceptions are:
* Repeated execution ("for i : 1 to 10000")
* Concurrency of the "outer" thread pool
* Each individual task is run (at least) once, enforced by the `Semaphore`.
* _More_ than one call to `vertx.setPeriodic()` (--> `EventExecutorGroup.scheduleAtFixedRate()`) in each "outer thread"
* Plus the `vertx.cancelTimer()`

I've run the test on a 16 core AMD Ryzen 9 CPU, each reproducer run triggers the failures. Removing one of the above first four "key parts" lets the test pass. It's reproducible in each invocation on my machine, but that doesn't necessarily mean it's 100% reproducible on every machine.

```java
import static java.util.concurrent.TimeUnit.MILLISECONDS;

import io.vertx.core.Vertx;
import io.vertx.core.VertxOptions;
import java.time.Duration;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.Executors;
import java.util.concurrent.Semaphore;
import java.util.stream.IntStream;
import org.assertj.core.api.SoftAssertions;
import org.assertj.core.api.junit.jupiter.InjectSoftAssertions;
import org.assertj.core.api.junit.jupiter.SoftAssertionsExtension;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;

@ExtendWith(SoftAssertionsExtension.class)
public class TestNettyScheduledFailure {
  @InjectSoftAssertions SoftAssertions soft;

  Vertx vertx;
  final Duration asyncTimeout = Duration.ofMinutes(5);

  @BeforeEach
  public void before() {
    vertx =
        Vertx.vertx(
            new VertxOptions()
                .setInternalBlockingPoolSize(16)
                .setEventLoopPoolSize(16)
                .setWorkerPoolSize(32));
  }

  @AfterEach
  public void after() {
    vertx.close();
  }

  @Test
  public void repro() throws Exception {
    var threads = 32;
    try (var exec = Executors.newFixedThreadPool(threads)) {
      for (int i = 0; i < 10000; i++) {
        CompletableFuture.allOf(
                IntStream.range(0, threads)
                    .mapToObj(
                        x ->
                            CompletableFuture.runAsync(
                                () -> {
                                  // .cancel() after first execution
                                  for (var initialDelay :
                                      List.of(Duration.ZERO, Duration.ofMillis(1))) {
                                    var sem = new Semaphore(0);

                                    var timerId = vertx.setPeriodic(1, 1, tid -> sem.release());

                                    try {
                                      soft.assertThat(
                                              sem.tryAcquire(asyncTimeout.toMillis(), MILLISECONDS))
                                          .describedAs("initialDelay %s", initialDelay)
                                          .isTrue();
                                    } catch (InterruptedException e) {
                                      throw new RuntimeException(e);
                                    }

                                    vertx.cancelTimer(timerId);
                                  }
                                  //
                                },
                                exec))
                    .toArray(CompletableFuture[]::new))
            .get();
      }
    }
  }
}
```

## Observed exceptions (io.vertx:*:4.5.14 -> io.netty:*:4.1.118.Final)

The following kinds of exceptions are thrown/logged, each multiple times.

```
java.lang.IllegalStateException: complete already: ScheduledFutureTask@34460055(failure: io.netty.util.concurrent.DefaultPromise$StacklessCancellationException, task: CANCELLED, deadline: 902001504, period: 1000000)
	at io.netty.util.concurrent.DefaultPromise.setFailure(DefaultPromise.java:113)
	at io.netty.util.concurrent.PromiseTask.setFailureInternal(PromiseTask.java:131)
	at io.netty.util.concurrent.ScheduledFutureTask.run(ScheduledFutureTask.java:176)
	at io.netty.util.concurrent.AbstractEventExecutor.runTask$$$capture(AbstractEventExecutor.java:173)
	at io.netty.util.concurrent.AbstractEventExecutor.runTask(AbstractEventExecutor.java)
	at io.netty.util.concurrent.AbstractEventExecutor.safeExecute$$$capture(AbstractEventExecutor.java:166)
	at io.netty.util.concurrent.AbstractEventExecutor.safeExecute(AbstractEventExecutor.java)
	at io.netty.util.concurrent.SingleThreadEventExecutor.runAllTasks(SingleThreadEventExecutor.java:472)
	at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:569)
	at io.netty.util.concurrent.SingleThreadEventExecutor$4.run(SingleThreadEventExecutor.java:998)
	at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74)
	at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30)
	at java.base/java.lang.Thread.run(Thread.java:1583)
Caused by: java.lang.AssertionError: null
	at io.netty.util.concurrent.ScheduledFutureTask.compareTo(ScheduledFutureTask.java:136)
	at io.netty.util.concurrent.AbstractScheduledEventExecutor$1.compare(AbstractScheduledEventExecutor.java:35)
	at io.netty.util.concurrent.AbstractScheduledEventExecutor$1.compare(AbstractScheduledEventExecutor.java:32)
	at io.netty.util.internal.DefaultPriorityQueue.bubbleUp(DefaultPriorityQueue.java:280)
	at io.netty.util.internal.DefaultPriorityQueue.offer(DefaultPriorityQueue.java:101)
	at io.netty.util.internal.DefaultPriorityQueue.offer(DefaultPriorityQueue.java:31)
	at java.base/java.util.AbstractQueue.add(AbstractQueue.java:95)
	at io.netty.util.concurrent.ScheduledFutureTask.run(ScheduledFutureTask.java:170)
	... 10 common frames omitted
```

```
Caused by: java.lang.NullPointerException: Cannot invoke "io.netty.util.concurrent.ScheduledFutureTask.deadlineNanos()" because "that" is null
	at io.netty.util.concurrent.ScheduledFutureTask.compareTo(ScheduledFutureTask.java:128)
	at io.netty.util.concurrent.AbstractScheduledEventExecutor$1.compare(AbstractScheduledEventExecutor.java:35)
	at io.netty.util.concurrent.AbstractScheduledEventExecutor$1.compare(AbstractScheduledEventExecutor.java:32)
	at io.netty.util.internal.DefaultPriorityQueue.bubbleUp(DefaultPriorityQueue.java:280)
	at io.netty.util.internal.DefaultPriorityQueue.offer(DefaultPriorityQueue.java:101)
	at io.netty.util.internal.DefaultPriorityQueue.offer(DefaultPriorityQueue.java:31)
	at java.base/java.util.AbstractQueue.add(AbstractQueue.java:95)
	at io.netty.util.concurrent.ScheduledFutureTask.run(ScheduledFutureTask.java:170)
	... 10 common frames omitted
```

```
java.lang.NullPointerException: Cannot invoke "io.netty.util.concurrent.ScheduledFutureTask.compareTo(java.util.concurrent.Delayed)" because "o1" is null
	at io.netty.util.concurrent.AbstractScheduledEventExecutor$1.compare(AbstractScheduledEventExecutor.java:35)
	at io.netty.util.concurrent.AbstractScheduledEventExecutor$1.compare(AbstractScheduledEventExecutor.java:32)
	at io.netty.util.internal.DefaultPriorityQueue.bubbleDown(DefaultPriorityQueue.java:251)
	at io.netty.util.internal.DefaultPriorityQueue.poll(DefaultPriorityQueue.java:116)
	at io.netty.util.internal.DefaultPriorityQueue.poll(DefaultPriorityQueue.java:31)
	at java.base/java.util.AbstractQueue.remove(AbstractQueue.java:113)
	at io.netty.util.concurrent.AbstractScheduledEventExecutor.pollScheduledTask(AbstractScheduledEventE

This same root cause must be fixed before merging.
REVIEW_EOF
