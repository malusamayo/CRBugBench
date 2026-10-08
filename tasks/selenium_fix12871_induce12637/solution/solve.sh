#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `py/selenium/webdriver/common/service.py`:

This pull request introduces the defect later reported as "[🐛 Bug]: logging to /dev/null remains dangling". The
problem a user observed, and its root cause:

### What happened?

```
ResourceWarning: unclosed file <_io.BufferedWriter name='/dev/null'>
```

that's caused by a bug in the following lines of code:
https://github.com/SeleniumHQ/selenium/blob/c64ed7d067f8314b2d3fbe3600dcc1ed47b866a4/py/selenium/webdriver/common/service.py#L138-L142

possibly this case is not covered:

https://github.com/SeleniumHQ/selenium/blob/c64ed7d067f8314b2d3fbe3600dcc1ed47b866a4/py/selenium/webdriver/common/service.py#L61-L62

likely was introduced in #12637

### How can we reproduce the issue?

```shell
Launch the Chrome WebDriver via Selenium
```


### Relevant log output

```shell
ResourceWarning: unclosed file <_io.BufferedWriter name='/dev/null'>
```
```


### Operating System

macOS

### Selenium version

Python 4.13.0

### What are the browser(s) and version(s) where you see this issue?

Chrome for Testing 117.0.5938.149

### What are the browser driver(s) and version(s) where you see this issue?

Chromedriver 117.0.5938.149

### Are you using Selenium Grid?

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
