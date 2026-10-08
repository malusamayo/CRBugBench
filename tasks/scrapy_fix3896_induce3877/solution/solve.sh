#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `scrapy/utils/conf.py`:

This pull request introduces the defect later reported as "Installing on CentOS7 (Python 2.7.5)". The
problem a user observed, and its root cause:

I've run `pip install scrapy`, but it doesn't seem that this has been installed properly.

Now when I ran `scrapy` on CLI, it ends up in the following message.

```
Traceback (most recent call last):
  File "/usr/bin/scrapy", line 6, in <module>
    from scrapy.cmdline import execute
  File "/usr/lib64/python2.7/site-packages/scrapy/cmdline.py", line 10, in <module>
    from scrapy.crawler import CrawlerProcess
  File "/usr/lib64/python2.7/site-packages/scrapy/crawler.py", line 11, in <module>
    from scrapy.core.engine import ExecutionEngine
  File "/usr/lib64/python2.7/site-packages/scrapy/core/engine.py", line 14, in <module>
    from scrapy.core.scraper import Scraper
  File "/usr/lib64/python2.7/site-packages/scrapy/core/scraper.py", line 18, in <module>
    from scrapy.core.spidermw import SpiderMiddlewareManager
  File "/usr/lib64/python2.7/site-packages/scrapy/core/spidermw.py", line 13, in <module>
    from scrapy.utils.conf import build_component_list
  File "/usr/lib64/python2.7/site-packages/scrapy/utils/conf.py", line 4, in <module>
    import configparser
ImportError: No module named configparser
```

I googled `configparser`, and apparently this used to be called `ConfigParser`.

Has anyone seen this issue?
Any advice will be appreciated.

This same root cause must be fixed before merging.
REVIEW_EOF
