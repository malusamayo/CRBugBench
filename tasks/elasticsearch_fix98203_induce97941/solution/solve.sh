#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `x-pack/docs/en/rest-api/security/get-builtin-privileges.asciidoc`:

This pull request introduces the defect later reported as "[CI] XDocsClientYamlTestSuiteIT test {yaml=en/rest-api/security/get-builtin-privileges/line_55} failing". The
problem a user observed, and its root cause:

Failed 16 times in the past 7 days.

If I tried the reproduction line I am getting the following error:

```
* What went wrong:
Could not determine the dependencies of task ':x-pack:docs:yamlRestTest'.
> Could not resolve all dependencies for configuration ':x-pack:docs:yamlRestTestRuntimeClasspath'.
   > Could not create task ':x-pack:plugin:core:processResources'.
      > Property license.key must be set for release build
````

It may be related to #95210.

**Build scan:**
https://gradle-enterprise.elastic.co/s/acudzmu2x5doc/tests/:x-pack:docs:yamlRestTest/org.elasticsearch.smoketest.XDocsClientYamlTestSuiteIT/test%20%7Byaml=en%2Frest-api%2Fsecurity%2Fget-builtin-privileges%2Fline_55%7D

**Reproduction line:**
```
./gradlew ':x-pack:docs:yamlRestTest' --tests "org.elasticsearch.smoketest.XDocsClientYamlTestSuiteIT.test {yaml=en/rest-api/security/get-builtin-privileges/line_55}" -Dtests.seed=4AC84FE06ACCAA3E -Dbuild.snapshot=false -Dtests.jvm.argline="-Dbuild.snapshot=false" -Dtests.locale=zh-Hant-HK -Dtests.timezone=Asia/Atyrau -Druntime.java=20
```

**Applicable branches:**
main

**Reproduces locally?:**
No

**Failure history:**
https://gradle-enterprise.elastic.co/scans/tests?tests.container=org.elasticsearch.smoketest.XDocsClientYamlTestSuiteIT&tests.test=test%20%7Byaml%3Den/rest-api/security/get-builtin-privileges/line_55%7D

**Failure excerpt:**
```
java.lang.AssertionError: Failure at [en/rest-api/security/get-builtin-privileges:15]: Expected a map containing
cluster: a list containing
        0: "all"
        1: "cancel_task"
        2: "create_snapshot"
        3: "delegate_pki"
        4: "grant_api_key"
        5: "manage"
        6: "manage_api_key"
        7: "manage_autoscaling"
        8: "manage_behavioral_analytics"
        9: "manage_ccr"
       10: "manage_data_frame_transforms"
       11: "manage_enrich"
       12: "manage_ilm"
       13: "manage_index_templates"
       14: "manage_ingest_pipelines"
       15: "manage_logstash_pipelines"
       16: "manage_ml"
       17: "manage_oidc"
       18: "manage_own_api_key"
       19: "manage_pipeline"
       20: "manage_rollup"
       21: "manage_saml"
       22: "manage_search_application"
       23: expected "manage_query_rules" but was "manage_search_query_rules"
       24: expected "manage_security" but was "manage_search_synonyms"
       25: expected "manage_service_account" but was "manage_security"
       26: expected "manage_slm" but was "manage_service_account"
       27: expected "manage_token" but was "manage_slm"
       28: expected "manage_transform" but was "manage_token"
       29: expected "manage_user_profile" but was "manage_transform"
       30: expected "manage_watcher" but was "manage_user_profile"
       31: expected "monitor" but was "manage_watcher"
       32: expected "monitor_data_frame_transforms" but was "monitor"
       33: expected "monitor_ml" but was "monitor_data_frame_transforms"
       34: expected "monitor_rollup" but was "monitor_ml"
       35: expected "monitor_snapshot" but was "monitor_rollup"
       36: expected "monitor_text_structure" but was "monitor_snapshot"
       37: expected "monitor_transform" but was "monitor_text_structure"
       38: expected "monitor_watcher" but was "monitor_transform"
       39: expected "none" but was "monitor_watcher"
       40: expected "post_behavioral_analytics_event" but was "none"
       41: expected "read_ccr" but was "post_behavioral_analytics_event"
       42: expected "read_ilm" but was "read_ccr"
       43: expected "read_pipeline" but was "read_ilm"
       44: expected "read_security" but was "read_pipeline"
       45: expected "read_slm" but was "read_security"
       46: expected "transport_client" but was "read_slm"
       47: <unexpected> but was "transport_client"
  index: a list containing
        0: "all"
        1: "auto_configure"
        2: "create"
        3: "create_doc"
        4: "create_index"
        5: "delete"
        6: "delete_index"
        7: "index"
        8: "maintenance"
        9: "manage"
       10: "manage_follow_index"
       11: "manage_ilm"
       12: "manage_leader_index"
       13: "monitor"
       14: "none"
       15: "read"
       16: "read_cross_cluster"
       17: "view_index_metadata"
       18: "write"

  at __randomizedtesting.SeedInfo.seed([4AC84FE06ACCAA3E:C29C703AC430C7C6]:0)
  at org.elasticsearch.test.rest.yaml.ESClientYamlSuiteTestCase.executeSection(ESClientYamlSuiteTestCase.java:571)
  at org.elasticsearch.test.rest.yaml.ESClientYamlSuiteTestCase.test(ESClientYamlSuiteTestCase.java:523)
  at jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:104)
  at java.lang.reflect.Method.invoke(Method.java:578)
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
  at com.carrotsearch.randomizedtesting.rules.Stat

This same root cause must be fixed before merging.
REVIEW_EOF
