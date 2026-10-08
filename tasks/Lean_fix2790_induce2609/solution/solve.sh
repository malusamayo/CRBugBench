#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Engine/DataFeeds/Synchronizer.cs`:

This pull request introduces the defect later reported as "Synchronizer live mode extra packet is throwing". The
problem a user observed, and its root cause:

<!--- This template provides sections for bugs and features. Please delete any irrelevant sections before submitting -->

#### Expected Behavior
<!--- Required. Describe the behavior you expect to see for your case. -->
- For live mode, the `Synchronizer` sends an extra empty package when `_subscriptionSynchronizer.Sync()` throws an exception
#### Actual Behavior
<!--- Required. Describe the actual behavior for your case. -->
- The extra packet logic is using an DateTime value which is set to `DateTime.MaxValue` causing an excepiton
#### Potential Solution
<!--- Optional. Describe any potential solutions and/or thoughts as to what may be causing the difference between expected and actual behavior. -->
- Use a valid DateTime value, could be `FrontierTimeProvider.GetUtcNow()`
#### Reproducing the Problem
<!--- Required for Bugs. Describe how to reproduce the problem. This can be via a failing unit test or a simplified algorithm that reliably demonstrates this issue.  -->
- Create a universe selecting more than 100 symbols
#### System Information
<!--- Required for Bugs. Include any system specific information, such as OS. -->
N/A
#### Checklist
<!--- Confirm that you've provided all the required information. -->
<!--- Required fields --->
- [x] I have completely filled out this template
- [x] I have confirmed that this issue exists on the current `master` branch
- [x] I have confirmed that this is not a duplicate issue by searching [issues](https://github.com/QuantConnect/Lean/issues)
<!--- Required for Bugs, feature request can delete the line below. -->
- [x] I have provided detailed steps to reproduce the issue

<!--- Template inspired by https://github.com/stevemao/github-issue-templates -->

This same root cause must be fixed before merging.
REVIEW_EOF
