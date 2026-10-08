#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `test/framework/src/main/java/org/elasticsearch/test/rest/RestTestLegacyFeatures.java`:

This pull request introduces the defect later reported as "[CI] FullClusterRestartIT testSlmPolicyAndStats {cluster=OLD} failing". The
problem a user observed, and its root cause:

**Build scan:**
https://gradle-enterprise.elastic.co/s/blgz7ddrj3zze/tests/:x-pack:qa:full-cluster-restart:v7.0.0%23bwcTest/org.elasticsearch.xpack.restart.FullClusterRestartIT/testSlmPolicyAndStats%20%7Bcluster=OLD%7D


**Reproduction line:**
```
./gradlew ':x-pack:qa:full-cluster-restart:v7.0.0#bwcTest' -Dtests.class="org.elasticsearch.xpack.restart.FullClusterRestartIT" -Dtests.method="testSlmPolicyAndStats {cluster=OLD}" -Dtests.seed=C3AE29B9585F31 -Dtests.bwc=true -Dtests.locale=tr -Dtests.timezone=Africa/Conakry -Druntime.java=21
```

**Applicable branches:**
main

**Reproduces locally?:**
Yes

**Failure history:**
[Failure dashboard for `org.elasticsearch.xpack.restart.FullClusterRestartIT#testSlmPolicyAndStats {cluster=OLD}`](https://es-delivery-stats.elastic.dev/app/dashboards#/view/dcec9e60-72ac-11ee-8f39-55975ded9e63?_g=(refreshInterval:(pause:!t,value:60000),time:(from:now-7d%2Fd,to:now))&_a=(controlGroupInput:(chainingSystem:HIERARCHICAL,controlStyle:twoLine,ignoreParentSettings:(ignoreFilters:!f,ignoreQuery:!f,ignoreTimerange:!f,ignoreValidations:!t),panels:('0c0c9cb8-ccd2-45c6-9b13-96bac4abc542':(explicitInput:(dataViewId:fbbdc689-be23-4b3d-8057-aa402e9ed0c5,enhancements:(),fieldName:task.keyword,grow:!t,id:'0c0c9cb8-ccd2-45c6-9b13-96bac4abc542',searchTechnique:wildcard,selectedOptions:!(),singleSelect:!t,title:'Gradle%20Task',width:medium),grow:!t,order:0,type:optionsListControl,width:small),'144933da-5c1b-4257-a969-7f43455a7901':(explicitInput:(dataViewId:fbbdc689-be23-4b3d-8057-aa402e9ed0c5,enhancements:(),fieldName:name.keyword,grow:!t,id:'144933da-5c1b-4257-a969-7f43455a7901',searchTechnique:wildcard,selectedOptions:!('testSlmPolicyAndStats%20%7Bcluster%3DOLD%7D'),title:Test,width:medium),grow:!t,order:2,type:optionsListControl,width:medium),'4e6ad9d6-6fdc-4fcc-bf1a-aa6ca79e0850':(explicitInput:(dataViewId:fbbdc689-be23-4b3d-8057-aa402e9ed0c5,enhancements:(),fieldName:className.keyword,grow:!t,id:'4e6ad9d6-6fdc-4fcc-bf1a-aa6ca79e0850',searchTechnique:wildcard,selectedOptions:!('org.elasticsearch.xpack.restart.FullClusterRestartIT'),title:Suite,width:medium),grow:!t,order:1,type:optionsListControl,width:medium)))))


**Failure excerpt:**
```
org.elasticsearch.client.ResponseException: method [PUT], host [http://[::1]:46297], URI [_slm/policy/test-policy], status line [HTTP/1.1 400 Bad Request]
Warnings: [[types removal] Specifying types in document index requests is deprecated, use the typeless endpoints instead (/{index}/_doc/{id}, /{index}/_doc, or /{index}/_create/{id}).]
{"error":{"root_cause":[{"type":"invalid_index_name_exception","reason":"Invalid index name [_slm], must not start with '_', '-', or '+'","index_uuid":"_na_","index":"_slm"}],"type":"invalid_index_name_exception","reason":"Invalid index name [_slm], must not start with '_', '-', or '+'","index_uuid":"_na_","index":"_slm"},"status":400}

  at __randomizedtesting.SeedInfo.seed([C3AE29B9585F31:1655EDE898D83F6D]:0)
  at org.elasticsearch.client.RestClient.convertResponse(RestClient.java:351)
  at org.elasticsearch.client.RestClient.performRequest(RestClient.java:317)
  at org.elasticsearch.client.RestClient.performRequest(RestClient.java:292)
  at org.elasticsearch.xpack.restart.FullClusterRestartIT.testSlmPolicyAndStats(FullClusterRestartIT.java:608)
  at jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
  at java.lang.reflect.Method.invoke(Method.java:580)
  at com.carrotsearch.randomizedtesting.RandomizedRunner.invoke(RandomizedRunner.java:1758)
  at com.carrotsearch.randomizedtesting.RandomizedRunner$8.evaluate(RandomizedRunner.java:946)
  at com.carrotsearch.randomizedtesting.RandomizedRunner$9.evaluate(RandomizedRunner.java:982)
  at com.carrotsearch.randomizedtesting.RandomizedRunner$10.evaluate(RandomizedRunner.java:996)
  at com.carrotsearch.randomizedtesting.rules.StatementAdapter.evaluate(StatementAdapter.java:36)
  at org.apache.lucene.tests.util.TestRuleSetupTeardownChained$1.evaluate(TestRuleSetupTeardownChained.java:48)
  at org.apache.lucene.tests.util.AbstractBeforeAfterRule$1.evaluate(AbstractBeforeAfterRule.java:43)
  at org.apache.lucene.tests.util.TestRuleThreadAndTestName$1.evaluate(TestRuleThreadAndTestName.java:45)
  at org.apache.lucene.tests.util.TestRuleIgnoreAfterMaxFailures$1.evaluate(TestRuleIgnoreAfterMaxFailures.java:60)
  at org.apache.lucene.tests.util.TestRuleMarkFailure$1.evaluate(TestRuleMarkFailure.java:44)
  at com.carrotsearch.randomizedtesting.rules.StatementAdapter.evaluate(StatementAdapter.java:36)
  at com.carrotsearch.randomizedtesting.ThreadLeakControl$StatementRunner.run(ThreadLeakControl.java:390)
  at com.carrotsearch.randomizedtesting.ThreadLeakControl.forkTimeoutingTask(ThreadLeakControl.java:843)
  at com.carrotsearch.randomizedtesting.ThreadLeakControl$3.evaluate(ThreadLeakControl.java:490)
  at com.carrotsearch.randomizedtesting.RandomizedRunner.runSingleTest(RandomizedRunner.java:955)
  at com.carrotsearch.randomizedtesting.RandomizedRunner$5.evaluate(RandomizedRunner.java:840)
  at com.carrotsearch.randomizedtesting.RandomizedRunner$6.evaluate(RandomizedRunner.java:891)
  at com.carrotsearch.randomizedtesting.RandomizedRunner$7.evaluate(RandomizedRunner.java:902)
  at org.elasticsearch.test.cluster.local.DefaultLocalElasticsearchCluster$1.evaluate(DefaultLocalElasticsearchCluster.java:47)
  at org.apache.lucene.tests.util.AbstractBeforeAfterRule$1.evaluate(AbstractBeforeAfterRule.java:43)
  at com.carrotsearch.randomizedtesting.rules.StatementAdapter.evaluate(StatementAdapter.java:36)
  at org.apache.lucene.tests.util.TestRuleStoreClassName$1.evaluate(TestRuleStoreClassName.java:38)
  at com.carrotsearch.randomizedtesting.rules.NoShadowingOrOverridesOnMethodsRule$1.evaluate(NoShadowingOrOverridesOnMethodsRule.java:40)
  at com.carrotsearch.randomizedtesting.rules.NoShadowingOrOverridesOnMethodsRule$1.evaluate(NoShadowingOrOverridesOnMethodsRule.java:40)
  at com.carrotsearch.randomizedtesting.rules.StatementAdapter.evaluate(StatementAdapter.java:36)
  at com.carrotsearch.randomizedtesting.rules.StatementAdapter.evaluate(StatementAdapter.java:36)
  at org.apache.lucene.tests.util.TestRuleAssertionsRequired$1.evaluate(TestRuleAssertionsRequired.java:53)
  at org.apache.lucene.tests.util.AbstractBeforeAfterRule$1.evaluate(AbstractBeforeAfterRule.java:43)
  at org.apache.lucene.tests.util.TestRuleMarkFailure$1.evaluate(TestRuleMarkFailure.java:44)
  at org.apache.lucene.tests.util.TestRuleIgnoreAfterMaxFailures$1.evaluate(TestRuleIgnoreAfterMaxFailures.java:60)
  at org.apache.lucene.tests.util.TestRuleIgnoreTestSuites$1.evaluate(TestRuleIgnoreTestSuites.java:47)
  at com.carrotsearch.randomizedtesting.rules.StatementAdapter.evaluate(StatementAdapter.java:36)
  at com.carrotsearch.randomizedtesting.ThreadLeakControl$StatementRunner.run(ThreadLeakControl.java:390)
  at com.carrotsearch.randomizedtesting.ThreadLeakControl.lambda$forkTimeoutingTask$0(ThreadLeakControl.java:850)
  at java.lang.Thread.run(Thread.java:1583)

```

This same root cause must be fixed before merging.
REVIEW_EOF
