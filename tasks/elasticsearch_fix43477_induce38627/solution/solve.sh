#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `x-pack/plugin/security/src/test/java/org/elasticsearch/xpack/security/authc/ApiKeyIntegTests.java`:

This pull request introduces the defect later reported as "[CI] ApiKeyIntegTests#testExpiredApiKeysBehaviorWhenKeysExpired1WeekBeforeAnd1DayBefore fails". The
problem a user observed, and its root cause:

On 7.x: https://elasticsearch-ci.elastic.co/job/elastic+elasticsearch+7.x+multijob-unix-compatibility/os=centos-6/143/console

Cannot reproduce locally:
```
./gradlew :x-pack:plugin:security:test --tests "org.elasticsearch.xpack.security.authc.ApiKeyIntegTests.testExpiredApiKeysBehaviorWhenKeysExpired1WeekBeforeAnd1DayBefore" \
  -Dtests.seed=84E00A79A9BD633 \
  -Dtests.security.manager=true \
  -Dtests.locale=ar-SD \
  -Dtests.timezone=Asia/Makassar \
  -Dcompiler.java=12 \
  -Druntime.java=8
```
```
java.lang.AssertionError: 
Expected: is <3>
     but: was <2>
	at __randomizedtesting.SeedInfo.seed([84E00A79A9BD633:D7D332CC16CF3C5A]:0)
	at org.hamcrest.MatcherAssert.assertThat(MatcherAssert.java:18)
	at org.junit.Assert.assertThat(Assert.java:956)
	at org.junit.Assert.assertThat(Assert.java:923)
	at org.elasticsearch.xpack.security.authc.ApiKeyIntegTests.testExpiredApiKeysBehaviorWhenKeysExpired1WeekBeforeAnd1DayBefore(ApiKeyIntegTests.java:366)
```

This same root cause must be fixed before merging.
REVIEW_EOF
