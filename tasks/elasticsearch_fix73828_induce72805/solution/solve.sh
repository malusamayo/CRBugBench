#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `x-pack/plugin/ml/src/test/java/org/elasticsearch/xpack/ml/job/categorization/FirstNonBlankLineCharFilterTests.java`:

This pull request introduces the defect later reported as "[ML] Token highlighting is completely haywire on long messages in categorization wizard with new default analyzer". The
problem a user observed, and its root cause:

**Kibana version:**

7.14.0-SNAPSHOT

**Elasticsearch version:**

7.14.0-SNAPSHOT

**Server OS version:**

macOS Catalina

**Browser version:**

Chrome 90.0.4430.212

**Browser OS version:**

macOS Catalina

**Original install method (e.g. download page, yum, from source, etc.):**

`gradle run` for Elasticsearch and `yarn start` for Kibana.

**Describe the bug:**

When creating a categorization job on some Elasticsearch logs using the new default categorization analyzer we are adding for 7.14 the token highlighting is completely wrong for some of the longer messages.  It's not just that the wrong characters are highlighted - the highlighting process seems to have completely messed up the text too.  Highlighted tokens seem to be printed on top of non-highlighted text in the wrong places.

Also, some other messages don't seem to have any tokens highlighted at all.

**Steps to reproduce:**
1. Upload a file called `logs.csv` using file upload - ping me to get a copy of this - and have the uploader create an index pattern for it
2. Create a new categorization job using the categorization wizard
3. On the first tab, ask to use the full time range of the data
4. On the second tab let the validation take place, then look at the example messages with highlighted tokens, and hopefully you'll see something similar to the screenshot below

**Expected behavior:**

Token highlighting should make sense and be rendered correctly.

**Screenshots (if relevant):**

<img width="1648" alt="Screenshot 2021-06-03 at 11 13 05" src="https://user-images.githubusercontent.com/7405510/120629380-aa1d9480-c45d-11eb-943b-0b9ee04a7722.png">

This same root cause must be fixed before merging.
REVIEW_EOF
