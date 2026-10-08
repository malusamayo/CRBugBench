#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/main/java/io/reactivex/internal/operators/flowable/FlowableRefCount.java`:

This pull request introduces the defect later reported as "2.x: refCount doesn't reset its source if one of its subscribers cancels immediately". The
problem a user observed, and its root cause:

The following tests fail because the cancel/dispose from the downstream comes before the actual connection is established which leaves the connectable source in a disposed state, refusing to take in new subscribers/observers:

```java
@Test
public void test() {
    BehaviorSubject<Integer> subject = BehaviorSubject.create();

    Observable<Integer> observable = subject
            .replay(1)
            .refCount();

    observable.takeUntil(Observable.just(1)).test();

    subject.onNext(2);

    observable.take(1).test().assertResult(2);
}


@Test
public void test2() {
    BehaviorProcessor<Integer> processor = BehaviorProcessor.create();

    Flowable<Integer> flowable = processor
            .replay(1)
            .refCount();

    // This line causes the test to fail.
    flowable.takeUntil(Flowable.just(1)).test();

    processor.onNext(2);

    flowable.take(1).test().assertResult(2);
}
```

This same root cause must be fixed before merging.
REVIEW_EOF
