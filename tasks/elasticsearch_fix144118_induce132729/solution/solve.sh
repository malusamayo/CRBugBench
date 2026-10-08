#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `x-pack/plugin/esql/src/main/java/org/elasticsearch/xpack/esql/expression/function/scalar/score/Decay.java`:

This pull request introduces the defect later reported as "ClassCastException in org.elasticsearch.xpack.esql.expression.function.scalar.score.Decay.toEvaluator". The
problem a user observed, and its root cause:

This failure was observed in Serverless:

```
java.lang.ClassCastException: class java.lang.Integer cannot be cast to class java.lang.Double
(java.lang.Integer and java.lang.Double are in module java.base of loader 'bootstrap')
    at org.elasticsearch.xpack.esql.expression.function.scalar.score.Decay.toEvaluator(Decay.java:376)
    at org.elasticsearch.xpack.esql.evaluator.EvalMapper.toEvaluator(EvalMapper.java:68)
    at org.elasticsearch.xpack.esql.planner.LocalExecutionPlanner.planEval(LocalExecutionPlanner.java:614)
    at org.elasticsearch.xpack.esql.planner.LocalExecutionPlanner.plan(LocalExecutionPlanner.java:293)
    at org.elasticsearch.xpack.esql.planner.LocalExecutionPlanner.planTopN(LocalExecutionPlanner.java:538)
    at org.elasticsearch.xpack.esql.planner.LocalExecutionPlanner.plan(LocalExecutionPlanner.java:291)
    at org.elasticsearch.xpack.esql.planner.LocalExecutionPlanner.planFieldExtractNode(LocalExecutionPlanner.java:464)
    at org.elasticsearch.xpack.esql.planner.LocalExecutionPlanner.plan(LocalExecutionPlanner.java:287)
    at org.elasticsearch.xpack.esql.planner.LocalExecutionPlanner.planProject(LocalExecutionPlanner.java:1149)
    at org.elasticsearch.xpack.esql.planner.LocalExecutionPlanner.plan(LocalExecutionPlanner.java:299)
    at org.elasticsearch.xpack.esql.planner.LocalExecutionPlanner.planExchangeSink(LocalExecutionPlanner.java:512)
    at org.elasticsearch.xpack.esql.planner.LocalExecutionPlanner.plan(LocalExecutionPlanner.java:346)
    at org.elasticsearch.xpack.esql.planner.LocalExecutionPlanner.plan(LocalExecutionPlanner.java:260)
    at org.elasticsearch.xpack.esql.plugin.ComputeService.runCompute(ComputeService.java:720)
    at org.elasticsearch.xpack.esql.plugin.DataNodeComputeHandler$DataNodeRequestExecutor.lambda$runBatch$4(DataNodeComputeHandler.java:373)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.ActionListener$2.onResponse(ActionListener.java:258)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.ActionRunnable$2.accept(ActionRunnable.java:58)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.ActionRunnable$2.accept(ActionRunnable.java:55)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.ActionRunnable$4.doRun(ActionRunnable.java:101)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.common.util.concurrent.AbstractRunnable.run(AbstractRunnable.java:27)
    at org.elasticsearch.xpack.esql.plugin.DataNodeComputeHandler$DataNodeRequestExecutor.lambda$acquireSearchContexts$6(DataNodeComputeHandler.java:442)
    at org.elasticsearch.base@9.4.0/org.elasticsearch.core.AbstractRefCounted$1.closeInternal(AbstractRefCounted.java:125)
    at org.elasticsearch.base@9.4.0/org.elasticsearch.core.AbstractRefCounted.decRef(AbstractRefCounted.java:77)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.support.RefCountingRunnable.close(RefCountingRunnable.java:122)
    at org.elasticsearch.xpack.esql.plugin.DataNodeComputeHandler$DataNodeRequestExecutor.acquireSearchContexts(DataNodeComputeHandler.java:455)
    at org.elasticsearch.xpack.esql.plugin.DataNodeComputeHandler$DataNodeRequestExecutor.runBatch(DataNodeComputeHandler.java:325)
    at org.elasticsearch.xpack.esql.plugin.DataNodeComputeHandler$DataNodeRequestExecutor.start(DataNodeComputeHandler.java:286)
    at org.elasticsearch.xpack.esql.plugin.DataNodeComputeHandler.runComputeOnDataNode(DataNodeComputeHandler.java:529)
    at org.elasticsearch.xpack.esql.plugin.DataNodeComputeHandler.messageReceived(DataNodeComputeHandler.java:614)
    at org.elasticsearch.xpack.esql.plugin.DataNodeComputeHandler.messageReceived(DataNodeComputeHandler.java:76)
    at org.elasticsearch.security@9.4.0/org.elasticsearch.xpack.security.transport.SecurityServerTransportInterceptor$ProfileSecuredRequestHandler$1.doRun(SecurityServerTransportInterceptor.java:318)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.common.util.concurrent.AbstractRunnable.run(AbstractRunnable.java:27)
    at org.elasticsearch.security@9.4.0/org.elasticsearch.xpack.security.transport.SecurityServerTransportInterceptor$ProfileSecuredRequestHandler$3.onResponse(SecurityServerTransportInterceptor.java:371)
    at org.elasticsearch.security@9.4.0/org.elasticsearch.xpack.security.transport.SecurityServerTransportInterceptor$ProfileSecuredRequestHandler$3.onResponse(SecurityServerTransportInterceptor.java:360)
    at org.elasticsearch.security@9.4.0/org.elasticsearch.xpack.security.authz.AuthorizationService.runRequestInterceptors(AuthorizationService.java:776)
    at org.elasticsearch.security@9.4.0/org.elasticsearch.xpack.security.authz.AuthorizationService.handleIndexActionAuthorizationResult(AuthorizationService.java:716)
    at org.elasticsearch.security@9.4.0/org.elasticsearch.xpack.security.authz.AuthorizationService.lambda$authorizeAction$10(AuthorizationService.java:543)
    at org.elasticsearch.security@9.4.0/org.elasticsearch.xpack.security.authz.AuthorizationService$AuthorizationResultListener.onResponse(AuthorizationService.java:1167)
    at org.elasticsearch.security@9.4.0/org.elasticsearch.xpack.security.authz.AuthorizationService$AuthorizationResultListener.onResponse(AuthorizationService.java:1133)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.support.ContextPreservingActionListener.onResponse(ContextPreservingActionListener.java:33)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.support.SubscribableListener$SuccessResult.complete(SubscribableListener.java:423)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.support.SubscribableListener.tryComplete(SubscribableListener.java:343)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.support.SubscribableListener.addListener(SubscribableListener.java:239)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.support.SubscribableListener.addListener(SubscribableListener.java:197)
    at org.elasticsearch.security@9.4.0/org.elasticsearch.xpack.security.authz.AuthorizationService.lambda$authorizeAction$11(AuthorizationService.java:541)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.ActionListener.run(ActionListener.java:468)
    at org.elasticsearch.security@9.4.0/org.elasticsearch.xpack.security.authz.AuthorizationService.lambda$authorizeAction$12(AuthorizationService.java:538)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.ActionListener$2.onResponse(ActionListener.java:258)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.support.SubscribableListener$SuccessResult.complete(SubscribableListener.java:423)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.support.SubscribableListener.tryComplete(SubscribableListener.java:343)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.support.SubscribableListener.addListener(SubscribableListener.java:239)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.support.SubscribableListener.addListener(SubscribableListener.java:197)
    at org.elasticsearch.security@9.4.0/org.elasticsearch.xpack.security.authz.AuthorizationService.authorizeAction(AuthorizationService.java:521)
    at org.elasticsearch.security@9.4.0/org.elasticsearch.xpack.security.authz.AuthorizationService.maybeAuthorizeRunAs(AuthorizationService.java:474)
    at org.elasticsearch.security@9.4.0/org.elasticsearch.xpack.security.authz.AuthorizationService.lambda$authorize$3(AuthorizationService.java:361)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.ActionListener$2.onResponse(ActionListener.java:258)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.support.ContextPreservingActionListener.onResponse(ContextPreservingActionListener.java:33)
    at org.elasticsearch.security@9.4.0/org.elasticsearch.xpack.security.authz.RBACEngine.lambda$resolveAuthorizationInfo$0(RBACEngine.java:179)
    at org.elasticsearch.server@9.4.0/org.elasticsearch.action.ActionListenerImplementations$ResponseWrapp

This same root cause must be fixed before merging.
REVIEW_EOF
