#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `test/Directory.Build.props`:

This pull request introduces the defect later reported as "Code coverage has been disabled for src directory". The
problem a user observed, and its root cause:

Pull request #2200 (unintentionally) caused the complete omission of code coverage information from the **src** directory.

The following line causes a problem in **Directory.Build.props**:

https://github.com/dotnet/machinelearning/blob/2f0c4755888e6a6a7f2f1206516479a8120a089b/test/Directory.Build.props#L9-L10

By placing this definition early in the build, the following does not take effect:

https://github.com/Microsoft/msbuild/blob/3a844ce00a873d8ca6ba0a8abc0c6b64f772d937/src/Tasks/Microsoft.Common.CurrentVersion.targets#L584-L594

Currently the test projects fail to copy assemblies and symbol files to the output directories, which completely breaks code coverage instrumentation for referenced projects. The property needs to be moved to **Directory.Build.targets** so it comes after the common definition.

This same root cause must be fixed before merging.
REVIEW_EOF
