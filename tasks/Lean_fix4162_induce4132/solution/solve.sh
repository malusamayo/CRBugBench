#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `Tests/Algorithm/Framework/Portfolio/MeanVarianceOptimizationPortfolioConstructionModelTests.cs`:

This pull request introduces the defect later reported as "Failing FactorFileGenerator unit tests". The
problem a user observed, and its root cause:

<!--- This template provides sections for bugs and features. Please delete any irrelevant sections before submitting -->

#### Expected Behavior
<!--- Required. Describe the behavior you expect to see for your case. -->
- FactorFileGeneratorTests do not fail
#### Actual Behavior
<!--- Required. Describe the actual behavior for your case. -->
- FactorFileGeneratorTests are currently failing when executed with portfolio unit tests added in PR https://github.com/QuantConnect/Lean/pull/4132 due to `SetUp : System.IO.IOException : The process cannot access the file 'D:\QuantConnect\MyLean\Lean\Data\equity\usa\daily\aapl.zip' because it is being used by another process.`
#### Potential Solution
<!--- Optional. Describe any potential solutions and/or thoughts as to what may be causing the difference between expected and actual behavior. -->
- Review reason of failure and add necessary clean up for portfolio unit tests
#### Reproducing the Problem
<!--- Required for Bugs. Describe how to reproduce the problem. This can be via a failing unit test or a simplified algorithm that reliably demonstrates this issue.  -->
Run all unit tests together
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
