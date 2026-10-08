#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `py/selenium/webdriver/support/expected_conditions.py`:

This pull request introduces the defect later reported as "[🐛 Bug]: ". The
problem a user observed, and its root cause:

### What happened?

Hello,

I'm using selenium=4.1.3 with python 3.7.

I think the [expected_conditions.text_to_be_present_in_element_attribute](https://github.com/SeleniumHQ/selenium/blob/trunk/py/selenium/webdriver/support/expected_conditions.py#L245) don't work the way it should.

![image](https://user-images.githubusercontent.com/1100288/166081670-7db741a1-5dbe-4367-bf8c-00cfef000103.png)

In the current code, the condition L245 is useless because [element_attribute_to_include ](https://github.com/SeleniumHQ/selenium/blob/trunk/py/selenium/webdriver/support/expected_conditions.py#L436)always return a function.

So L247 will return None if the attribute doesn't exists and L248 will raise a TypeError: argument of type 'NoneType' is not iterable.


I think the intended behavior is : 
`
if not element_attribute_to_include(locator, attribute_)(driver):
    return False
`



### How can we reproduce the issue?

```shell
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.expected_conditions import text_to_be_present_in_element_attribute

driver = webdriver.Chrome()
driver.get("https://google.com")

tester = text_to_be_present_in_element_attribute((By.CSS_SELECTOR, "body"), "missingattribute", "oups")
tester(driver)
```


### Relevant log output

```shell
Traceback (most recent call last):
  File "lib\site-packages\selenium\webdriver\support\expected_conditions.py", line 248, in _predicate
    return text_ in element_text
TypeError: argument of type 'NoneType' is not iterable
```


### Operating System

Windows 10

### Selenium version

4.1.3

### What are the browser(s) and version(s) where you see this issue?

Chrome 101

### What are the browser driver(s) and version(s) where you see this issue?

ChromeDriver 101.0.4951.41

### Are you using Selenium Grid?

_No response_

This same root cause must be fixed before merging.
REVIEW_EOF
