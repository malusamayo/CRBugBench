#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/main/java/io/reactivex/internal/operators/flowable/FlowableMergeWithCompletable.java`:

This pull request introduces the defect later reported as "using Observable#mergeWith(CompletableSource), upstream occurs an error, but the ComletableSource won't be disposed". The
problem a user observed, and its root cause:

using Observable#mergeWith(CompletableSource), upstream occurs an error, but the ComletableSource won't be disposed.

```java
Observable.create(new ObservableOnSubscribe<Object>() {
    @Override
    public void subscribe(ObservableEmitter<Object> emitter) throws Exception {
        Schedulers.io().scheduleDirect(
            () -> emitter.tryOnError(new Throwable("occurs error")),
            1, TimeUnit.SECONDS);
        }
    })
    .mergeWith(
        Completable.create(emmit ->
            emmit.setCancellable(() -> System.out.println("mergeWith dispose"))
         )
         .doOnSubscribe(dis -> System.out.println("mergeWith doOnSubscribe"))
    )
    .subscribe(ob -> {}, System.out::println);
```
the result is :
```
mergeWith doOnSubscribe
java.lang.Throwable: occurs error
```

but if add 'toObservable()' 
```
Observable.create(new ObservableOnSubscribe<Object>() {
            @Override
            public void subscribe(ObservableEmitter<Object> emitter) throws Exception {
                Schedulers.io().scheduleDirect(() -> emitter.tryOnError(new Throwable("occurs error")), 1, TimeUnit.SECONDS);
            }
        })
                .mergeWith(Completable.create(emmit ->
                        emmit.setCancellable(() -> System.out.println("mergeWith dispose")))
                        .doOnSubscribe(dis -> System.out.println("mergeWith doOnSubscribe")).toObservable())
                .subscribe(ob -> {}, System.out::println);
```

the result is: 
```
mergeWith doOnSubscribe
mergeWith dispose
java.lang.Throwable: occurs error
```

The 'dispose' will be invoked。
In case of first,it will produce a memory leak.
Is that a bug?

This same root cause must be fixed before merging.
REVIEW_EOF
