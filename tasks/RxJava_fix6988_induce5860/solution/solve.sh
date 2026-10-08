#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/main/java/io/reactivex/rxjava3/internal/operators/flowable/FlowableGroupBy.java`:

This pull request introduces the defect later reported as "Flowable.groupBy hangs with group consumed via observeOn and take(timed)". The
problem a user observed, and its root cause:

Continuing evaluating the problems from #6974

The following test hangs after a while:

```java
    @Test
    public void issue6974Part2Case1ObserveOnNoCap() {
        final int groups = 20;
        int flatMapMaxConcurrency = 1_000_000;

        Flowable
        .range(1, 500_000)
        .map(i -> i % groups)
        .doOnRequest(v -> {
            System.out.println("Source: " + v);
        })
        .groupBy(i -> i)
        .flatMap(gf -> gf
                     .observeOn(Schedulers.computation())
                     .take(10, TimeUnit.MILLISECONDS)
            , flatMapMaxConcurrency)
        .test()
        .awaitDone(5, TimeUnit.SECONDS)
        .assertNoErrors()
        .assertComplete();
    }
```

Adding `hide` makes it pass which indicates the fusion between the group and `observeOn` seems to stop requesting more items.

This same root cause must be fixed before merging.
REVIEW_EOF
