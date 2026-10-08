#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/main/java/io/reactivex/rxjava3/internal/schedulers/AbstractDirectTask.java`:

This pull request introduces the defect later reported as "3.x Flowable#sample may complete on an interrupted thread". The
problem a user observed, and its root cause:

Hi !

Using version 3.0.10, and the following code:
```java
int i = 0;
while (true) {
        System.out.println("i = " + i++);
        PublishSubject<Long> subj = PublishSubject.create();
        subj.toFlowable(BackpressureStrategy.ERROR)
	        .sample(10, TimeUnit.MILLISECONDS)
	        .doFinally(() -> {
		        System.out.println(String.format("Current thread %s is interrupted: %b", 
                                        Thread.currentThread().getName(),
				        Thread.currentThread().isInterrupted())
                        );
		        if (Thread.currentThread().isInterrupted()) {
			        System.exit(1);
		        }
	        })
	        .subscribe();
        subj.onNext(1L);
        
        Observable.timer(10, TimeUnit.MILLISECONDS)
	        .blockingSubscribe(any -> subj.onComplete());
}
```
the loop ends after a few iterations (usually between 250 and 300 on my device).

The first iterations give: `Current thread main is interrupted: false`.
And the last: `Current thread RxComputationThreadPool-7 is interrupted: true`.

I quite understand why I get this result, but I'm still surprised by it. Is it an known/accepted/intended behavior ?

NB 1: Using `buffer` unstead of `sample` gives the same result.
NB 2: Changing `sample` scheduler to `Schedulers.from(Executors.newSingleThreadExecutor(...))` causes the loop to never end.
NB 3: First observed with RxJava2, with no change in behavior.

This same root cause must be fixed before merging.
REVIEW_EOF
