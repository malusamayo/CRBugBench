#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/main/java/io/reactivex/rxjava3/internal/operators/observable/ObservableFlatMap.java`:

This pull request introduces the defect later reported as "Deadlock". The
problem a user observed, and its root cause:

RXJava 3.0.1.
I randomly got into a weird situation where my code entered a deadlock and I don't know why.
I simplified the code and got to the below part which will enter a deadlock and never return.
This seems like a bug, but maybe I'm missing something.
The code:
```java
Observable
    .range(1, 20)
    .flatMap(
            integer -> {
                if (integer % 5 != 0) {
                    return Observable
                            .just(integer);
                }

                return Observable
                        .just(-integer)
                        .observeOn(Schedulers.io());
            },
            false,
            1
    )
    .ignoreElements()
    .blockingAwait();
```

This same root cause must be fixed before merging.
REVIEW_EOF
