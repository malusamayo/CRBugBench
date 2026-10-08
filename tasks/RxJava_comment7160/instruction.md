# Code Review Task

You are a maintainer reviewing a pull request to the `ReactiveX/RxJava` repository.

**PR title:** Io Scheduler, Scheduled worker release.

**PR description:**

`IoScheduler` releases the workers back to the pool to be reused optimistically to reduce the number of threads being created. This could lead to deadlocks in some situations like this one:

```
Flowable.just("item")
        .observeOn(Schedulers.io())
        .firstOrError()
        .subscribe(__ -> {
            for (int i = 0; i < 200; i++) {
                Completable.complete()
                        .observeOn(Schedulers.io())
                        .blockingAwait();
            }
            System.out.println("Will never reach this");
        });
```
As discussed on https://github.com/ReactiveX/RxJava/issues/7153, this PR allow to configure this behaviour.
Enabling `rx3.io-scheduled-release` will guarantee that workers are not reused until all the processing has finished. 

Once we merge this we, I can create a similar PR for the `2.x` branch

## Working environment

The repository is checked out at `/app/RxJava` at this PR's **base commit**
(the state before this PR), and the proposed change is present two ways:

- applied as **uncommitted modifications** to the working tree (run `git diff`
  to see it, or use a review tool that inspects the local git diff), and
- saved as a unified diff at `/app/pr_to_review.diff`.

Use `git log` and `git show HEAD:<path>` (HEAD is the base commit) for
surrounding history, call sites, and conventions.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
