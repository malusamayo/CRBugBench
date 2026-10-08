#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `java/src/org/openqa/selenium/manager/SeleniumManager.java`:

This pull request introduces the defect later reported as "[🐛 Bug]: "Cannot run program "/home/runner/.cache/selenium/manager/0.4.35/selenium-manager": error=26, Text file busy"". The
problem a user observed, and its root cause:

### Description

It's the same error as https://github.com/seleniumHQ/selenium/issues/13145 (which was closed unfortunately).

When running SeleniumManager in parallel processes (on a machine with empty selenium cache),
this concurrency error happens:

```java
org.openqa.selenium.remote.NoSuchDriverException: Unable to obtain: chromedriver, error Failed to run command: [--browser, chrome, --language-binding, java, --output, json]
    Build info: version: '4.35.0', revision: '1c58e5028b'
    System info: os.name: 'Linux', os.arch: 'amd64', os.version: '6.11.0-1018-azure', java.version: '17.0.16'
    Driver info: driver.version: SelenideDriver
        at app//org.openqa.selenium.remote.service.DriverFinder.getBinaryPaths(DriverFinder.java:124)
        at app//org.openqa.selenium.remote.service.DriverFinder.getDriverPath(DriverFinder.java:55)
        at app//org.openqa.selenium.chrome.ChromeDriver.generateExecutor(ChromeDriver.java:99)
        at app//org.openqa.selenium.chrome.ChromeDriver.<init>(ChromeDriver.java:88)
        at app//org.openqa.selenium.chrome.ChromeDriver.<init>(ChromeDriver.java:83)
        ...

            Caused by:
            java.io.UncheckedIOException: java.io.IOException: Cannot run program "/home/runner/.cache/selenium/manager/0.4.35/selenium-manager": error=26, Text file busy
                at org.openqa.selenium.os.ExternalProcess$Builder.start(ExternalProcess.java:195)
                at org.openqa.selenium.manager.SeleniumManager.runCommand(SeleniumManager.java:142)
                ... 29 more

                Caused by:
                java.io.IOException: Cannot run program "/home/runner/.cache/selenium/manager/0.4.35/selenium-manager": error=26, Text file busy
                    at java.base/java.lang.ProcessBuilder.start(ProcessBuilder.java:1143)
                    at java.base/java.lang.ProcessBuilder.start(ProcessBuilder.java:1073)
                    at org.openqa.selenium.os.ExternalProcess$Builder.start(ExternalProcess.java:193)
                    ... 30 more

                    Caused by:
                    java.io.IOException: error=26, Text file busy
                        at java.base/java.lang.ProcessImpl.forkAndExec(Native Method)
                        at java.base/java.lang.ProcessImpl.<init>(ProcessImpl.java:314)
                        at java.base/java.lang.ProcessImpl.start(ProcessImpl.java:244)
                        at java.base/java.lang.ProcessBuilder.start(ProcessBuilder.java:1110)
                        ... 32 more
```

The problem is in method `org.openqa.selenium.manager.SeleniumManager#getBinary`.
Here happens the concurrency issue:
1. Process A starts writing bytes to file `~/.cache/selenium/manager/0.4.36/selenium-manager` (it will take some time)
2. Process B sees that file `~/.cache/selenium/manager/0.4.36/selenium-manager` already exists and starts using it.
3. But the file is not fully completed yet

### Reproducible Code

```shell
1. Clone https://github.com/asolntsev/selenium-manager-bug
2. Run `./gradlew`
```

### Real failure example:

https://github.com/replay-framework/replay/actions/runs/17452318682/job/49559368292

This same root cause must be fixed before merging.
REVIEW_EOF
