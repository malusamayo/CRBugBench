# Code Review Task

You are a maintainer reviewing a pull request to the `netty/netty` repository.

**PR title:** Fix AccessControlException in GlobalEventExecutor

**PR description:**

Motivation: fix recently introduced (as part of https://github.com/netty/netty/pull/14623) `java.security.AccessControlException`, here is the relevant stack trace

```
java.security.AccessControlException: access denied ("java.lang.RuntimePermission" "getClassLoader")                                                                       
        at java.base/java.security.AccessControlContext.checkPermission(AccessControlContext.java:488) ~[?:?]                                                              
        at java.base/java.security.AccessController.checkPermission(AccessController.java:1085) ~[?:?]                                                                     
        at java.base/java.lang.SecurityManager.checkPermission(SecurityManager.java:411) ~[?:?]                                                                            
        at java.base/java.lang.ClassLoader.checkClassLoaderPermission(ClassLoader.java:2071) ~[?:?]                                                                        
        at java.base/java.lang.Thread.getContextClassLoader(Thread.java:2284) ~[?:?]
        at io.netty.util.concurrent.GlobalEventExecutor.startThread(GlobalEventExecutor.java:239) ~[netty-common-4.1.117.Final.jar:4.1.117.Final]
        at io.netty.util.concurrent.GlobalEventExecutor.execute0(GlobalEventExecutor.java:232) ~[netty-common-4.1.117.Final.jar:4.1.117.Final]
        at io.netty.util.concurrent.GlobalEventExecutor.execute(GlobalEventExecutor.java:226) ~[netty-common-4.1.117.Final.jar:4.1.117.Final]
        at io.netty.util.concurrent.DefaultPromise.safeExecute(DefaultPromise.java:862) [netty-common-4.1.117.Final.jar:4.1.117.Final]
        at io.netty.util.concurrent.DefaultPromise.notifyListeners(DefaultPromise.java:500) [netty-common-4.1.117.Final.jar:4.1.117.Final]
        at io.netty.util.concurrent.DefaultPromise.setValue0(DefaultPromise.java:636) [netty-common-4.1.117.Final.jar:4.1.117.Final]
        at io.netty.util.concurrent.DefaultPromise.setSuccess0(DefaultPromise.java:625) [netty-common-4.1.117.Final.jar:4.1.117.Final]
        at io.netty.util.concurrent.DefaultPromise.setSuccess(DefaultPromise.java:97) [netty-common-4.1.117.Final.jar:4.1.117.Final]
        at io.netty.util.concurrent.SingleThreadEventExecutor$4.run(SingleThreadEventExecutor.java:1059) [netty-common-4.1.117.Final.jar:4.1.117.Final]
        at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74) [netty-common-4.1.117.Final.jar:4.1.117.Final]
        at java.base/java.lang.Thread.run(Thread.java:1575) [?:?]
```

Modification:

Apply `AccessController.doPrivileged` block

Result:

With the proper security policy, the exception is gone

Affected Version: 4.1.117.Final

## Working environment

The repository is checked out at `/app/netty` at this PR's **base commit**
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
