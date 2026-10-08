#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `server/src/internalClusterTest/java/org/elasticsearch/repositories/blobstore/BlobStoreRepositoryCleanupIT.java`:

This pull request introduces the defect later reported as "[CI] BlobStoreRepositoryCleanupIT.testMasterFailoverDuringCleanup". The
problem a user observed, and its root cause:

**Build scan**: https://gradle-enterprise.elastic.co/s/hxjhopehss5ag

**Repro line**: `./gradlew ':server:internalClusterTest' --tests "org.elasticsearch.repositories.blobstore.BlobStoreRepositoryCleanupIT.testMasterFailoverDuringCleanup" -Dtests.seed=A5C9D3D7B6977447 -Dtests.security.manager=true -Dtests.locale=ko-KR -Dtests.timezone=EET -Druntime.java=8`

**Reproduces locally?**: No

**Applicable branches**: 7.x, 7.12, 7.11

**Failure history**: https://build-stats.elastic.co/goto/8e9ed248199698dea8b4e63975336e8f

**Failure excerpt**:

```
  | java.lang.IllegalStateException: Cannot cleanup [test-repo] - a repository cleanup is already in-progress in [{"repository_cleanup":[{"repository":"test-repo"}]}] |  
at org.elasticsearch.action.admin.cluster.repositories.cleanup.TransportCleanupRepositoryAction$2.execute(TransportCleanupRepositoryAction.java:167) |  
  |   | at org.elasticsearch.cluster.ClusterStateUpdateTask.execute(ClusterStateUpdateTask.java:48) |  
  |   | at org.elasticsearch.cluster.service.MasterService.executeTasks(MasterService.java:691) |  
  |   | at org.elasticsearch.cluster.service.MasterService.calculateTaskOutputs(MasterService.java:313) |  
  |   | at org.elasticsearch.cluster.service.MasterService.runTasks(MasterService.java:208) |  
  |   | at org.elasticsearch.cluster.service.MasterService.access$000(MasterService.java:62) |  
  |   | at org.elasticsearch.cluster.service.MasterService$Batcher.run(MasterService.java:140) |  
  |   | at org.elasticsearch.cluster.service.TaskBatcher.runIfNotProcessed(TaskBatcher.java:139) |  
  |   | at org.elasticsearch.cluster.service.TaskBatcher$BatchedTask.run(TaskBatcher.java:177) |  
  |   | at org.elasticsearch.common.util.concurrent.ThreadContext$ContextPreservingRunnable.run(ThreadContext.java:673) |  
  |   | at org.elasticsearch.common.util.concurrent.PrioritizedEsThreadPoolExecutor$TieBreakingPrioritizedRunnable.runAndClean(PrioritizedEsThreadPoolExecutor.java:241) |  
  |   | at org.elasticsearch.common.util.concurrent.PrioritizedEsThreadPoolExecutor$TieBreakingPrioritizedRunnable.run(PrioritizedEsThreadPoolExecutor.java:204) |  
  |   | at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149) |  
  |   | at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624) |  
  |   | at java.lang.Thread.run(Thread.java:748)
```

This same root cause must be fixed before merging.
REVIEW_EOF
