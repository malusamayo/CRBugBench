#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `languagetool-core/src/main/java/org/languagetool/rules/spelling/hunspell/HunspellRule.java`:

This pull request introduces the defect later reported as "Maven Clean Test Failure on language-fr". The
problem a user observed, and its root cause:

Attempting to run the command 'mvn clean test' results in the following error and log:

[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  01:29 min
[INFO] Finished at: 2019-12-02T08:43:41Z
[INFO] ------------------------------------------------------------------------
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-surefire-plugin:2.22.0:test (default-test) on project language-fr: There are test failures.
[ERROR]
[ERROR] Please refer to C:\Users\Jack\Downloads\languagetool\languagetool-language-modules\fr\target\surefire-reports for the individual test results.
[ERROR] Please refer to dump files (if any exist) [date]-jvmRun[N].dump, [date].dumpstream and [date]-jvmRun[N].dumpstream.
[ERROR] -> [Help 1]
[ERROR]

-------------------------------------------------------------------------------
Test set: org.languagetool.rules.spelling.hunspell.HunspellRuleTest
-------------------------------------------------------------------------------
Tests run: 2, Failures: 1, Errors: 0, Skipped: 0, Time elapsed: 3.094 s <<< FAILURE! - in org.languagetool.rules.spelling.hunspell.HunspellRuleTest
testRuleWithFrench(org.languagetool.rules.spelling.hunspell.HunspellRuleTest)  Time elapsed: 1.815 s  <<< FAILURE!
java.lang.AssertionError: Got != 0 matches for: Aujourd’hui et jusqu’à demain.: [HUNSPELL_RULE:0-7:Faute de frappe possible trouvée, HUNSPELL_RULE:8-11:Faute de frappe possible trouvée, HUNSPELL_RULE:15-20:Faute de frappe possible trouvée]
	at org.junit.Assert.fail(Assert.java:88)
	at org.languagetool.rules.spelling.hunspell.HunspellRuleTest.test(HunspellRuleTest.java:63)
	at org.languagetool.rules.spelling.hunspell.HunspellRuleTest.testRuleWithFrench(HunspellRuleTest.java:54)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.junit.runners.model.FrameworkMethod$1.runReflectiveCall(FrameworkMethod.java:50)
	at org.junit.internal.runners.model.ReflectiveCallable.run(ReflectiveCallable.java:12)
	at org.junit.runners.model.FrameworkMethod.invokeExplosively(FrameworkMethod.java:47)
	at org.junit.internal.runners.statements.InvokeMethod.evaluate(InvokeMethod.java:17)
	at org.junit.runners.ParentRunner.runLeaf(ParentRunner.java:325)
	at org.junit.runners.BlockJUnit4ClassRunner.runChild(BlockJUnit4ClassRunner.java:78)
	at org.junit.runners.BlockJUnit4ClassRunner.runChild(BlockJUnit4ClassRunner.java:57)
	at org.junit.runners.ParentRunner$3.run(ParentRunner.java:290)
	at org.junit.runners.ParentRunner$1.schedule(ParentRunner.java:71)
	at org.junit.runners.ParentRunner.runChildren(ParentRunner.java:288)
	at org.junit.runners.ParentRunner.access$000(ParentRunner.java:58)
	at org.junit.runners.ParentRunner$2.evaluate(ParentRunner.java:268)
	at org.junit.runners.ParentRunner.run(ParentRunner.java:363)
	at org.apache.maven.surefire.junit4.JUnit4Provider.execute(JUnit4Provider.java:365)
	at org.apache.maven.surefire.junit4.JUnit4Provider.executeWithRerun(JUnit4Provider.java:273)
	at org.apache.maven.surefire.junit4.JUnit4Provider.executeTestSet(JUnit4Provider.java:238)
	at org.apache.maven.surefire.junit4.JUnit4Provider.invoke(JUnit4Provider.java:159)
	at org.apache.maven.surefire.booter.ForkedBooter.invokeProviderInSameClassLoader(ForkedBooter.java:383)
	at org.apache.maven.surefire.booter.ForkedBooter.runSuitesInProcess(ForkedBooter.java:344)
	at org.apache.maven.surefire.booter.ForkedBooter.execute(ForkedBooter.java:125)
	at org.apache.maven.surefire.booter.ForkedBooter.main(ForkedBooter.java:417)

This same root cause must be fixed before merging.
REVIEW_EOF
