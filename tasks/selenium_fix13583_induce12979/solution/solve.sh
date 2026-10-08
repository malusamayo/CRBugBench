#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `java/src/org/openqa/selenium/HasDownloads.java`:

This pull request introduces the defect later reported as "[🐛 Bug]: NPE in HasDownloads.requireDownloadsEnabled() when using local browser". The
problem a user observed, and its root cause:

### What happened?

First of all, thank you for the new download function. It works really well.

Even though [the documentation](https://www.selenium.dev/documentation/grid/configuration/cli_options/#enabling-managed-downloads-by-the-node) clearly indicates that a download is only supported via a Selenium Grid, I found an unfortunate NPE when trying to perform a download without Selenium Grid.

The NPE occurs when `HasDownloads.requireDownloadsEnabled()` tries to cast the return value of `capabilities.getCapability("se:downloadsEnabled")` to a boolean. In the case of a locally launched browser, `capabilities.getCapability("se:downloadsEnabled")` returns `null`, causing the following NPE:

`java.lang.NullPointerException: Cannot invoke "java.lang.Boolean.booleanValue()" because the return value of "org.openqa.selenium.Capabilities.getCapability(String)" is null`

I think there are to ways to prevent this NPE.

- Changing `(boolean) capabilities.getCapability("se:downloadsEnabled")` to `Boolean.parseBoolean(capabilities.getCapability("se:downloadsEnabled"))` since it will evaluate `null` to `false`.
- Check for `null` and throw a WebDriverException stating that downloads are only supported when running tests via Selenium Grid:
```java
Object downloadCapability = capabilities.getCapability("se:downloadsEnabled");
    if (downloadCapability == null) {
      throw new WebDriverException("Use a Selenium Grid in order to work with downloadable files.")
    }
    boolean downloadsEnabled = (boolean) downloadCapability;
    if (!downloadsEnabled) {
      throw new WebDriverException(
          "You must enable downloads in order to work with downloadable files.");
    }
```

### How can we reproduce the issue?

```shell
public static void main(String[] args) throws InterruptedException {
        ChromeOptions chromeOptions = new ChromeOptions();
        chromeOptions.setEnableDownloads(true);
        WebDriver driver = new ChromeDriver(chromeOptions);
        driver.navigate().to("https://www.selenium.dev/downloads/");
        WebDriver augmentedDriver = new Augmenter().augment(driver);

        // This will cause the NPE
        List<String> downloadedFiles = ((HasDownloads) augmentedDriver).getDownloadableFiles();
}
```


### Relevant log output

```shell
Exception in thread "main" java.lang.NullPointerException: Cannot invoke "java.lang.Boolean.booleanValue()" because the return value of "org.openqa.selenium.Capabilities.getCapability(String)" is null
	at org.openqa.selenium.HasDownloads.requireDownloadsEnabled(HasDownloads.java:36)
	at org.openqa.selenium.remote.RemoteWebDriver.getDownloadableFiles(RemoteWebDriver.java:636)
```


### Operating System

Windows 10

### Selenium version

Java 4.17.0

### What are the browser(s) and version(s) where you see this issue?

Chrome 121

### What are the browser driver(s) and version(s) where you see this issue?

ChromeDriver 121

### Are you using Selenium Grid?

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
