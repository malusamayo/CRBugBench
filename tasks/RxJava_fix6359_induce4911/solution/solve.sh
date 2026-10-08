#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/main/java/io/reactivex/internal/operators/observable/ObservableRepeatWhen.java`:

This pull request introduces the defect later reported as "2.x: Disposable already set! using delaySubscription with takeUntil/repeatWhen". The
problem a user observed, and its root cause:

Issue encountered in: io.reactivex.rxjava2:rxjava:2.2.4

When using a combination of takeUntil/repeatWhen operators on an Observable with delaySubscription operator applied, it is possible to encounter a ProtocolViolationException: Disposable already set! thrown by RepeatWhenObserver#onSubscribe. It appears that if delaySubscription uses an ObservableSource which rapidly/concurrently emits multiple notifications a rare race condition leads to a double subscription issue.

I am not sure if this issue is a user error (take(1) on ObservableSource supplied to delaySubscription alleviates it) or a bug in RxJava however the following, slow unit test demonstrates it:

```java

    @Test
    public void delaySubscriptionWithRepeatWhen() {
        List<Throwable> errors = TestHelper.trackPluginErrors();

        ExecutorService executor = Executors.newFixedThreadPool(2);
        try {
            Observable<Object> subscriptionSignal = Observable.merge(
                    Observable.just(new Object()).delay(0, TimeUnit.MILLISECONDS),
                    Observable.just(new Object()).delay(0, TimeUnit.MILLISECONDS)
            );

            final Subject<Boolean> boolStream = PublishSubject.<Boolean>create().toSerialized();

            Observable<Boolean> brokenStream = boolStream
                    .delaySubscription(subscriptionSignal)
                    .takeUntil(new Predicate<Boolean>()  {
                        @Override
                        public boolean test(Boolean state) throws Exception {
                            return state;
                        }
                    })
                    .repeatWhen(new Function<Observable<Object>, ObservableSource<?>>() {
                        @Override
                        public ObservableSource<?> apply(Observable<Object> objectObservable) throws Exception {
                            return boolStream.filter(new Predicate<Boolean>() {
                                @Override
                                public boolean test(Boolean state) throws Exception {
                                    return !state;
                                }
                            });
                        }
                    });

            final Random random = new Random();
            for (int i = 0; i < 1000000; i++) {
                final TestObserver<Boolean> testObserver = brokenStream.test();
                executor.execute(new Runnable() {
                    @Override
                    public void run() {
                        boolStream.onNext(random.nextBoolean());
                        testObserver
                                .assertNoErrors()
                                .dispose();
                    }
                });
                if (!errors.isEmpty()) {
                    fail("Uncaught fatal errors: " + errors);
                }
            }
        } finally {
            executor.shutdown();
            try {
                executor.awaitTermination(30, TimeUnit.SECONDS);
            } catch (InterruptedException e) {
            }
        }
    }
```

This same root cause must be fixed before merging.
REVIEW_EOF
