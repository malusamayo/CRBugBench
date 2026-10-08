#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `docs/samples/Microsoft.ML.Samples.GPU/Microsoft.ML.Samples.GPU.csproj`:

This pull request introduces the defect later reported as "Problems caused by ML.Samples and ML.Samples.GPU sharing the same Program.cs file". The
problem a user observed, and its root cause:

### Issue

**What did you do?**: I modified the Program.cs file in the ML.Samples project to run a sample that exists in the Samples.Dynamic.Trainers.Regression namespace.

**What happened?**:
Since ML.Samples and ML.Samples.GPU share the same Program.cs file, my changes in the Program.cs under ML.Samples had effects on the ML.Samples.GPU project.

An error appeared in the Program.cs file inside the ML.Samples.GPU project saying that the namespace Samples.Dynamic didn't have a name 'Trainers' and that I might have been missing an assembly reference. Also, while editing the Program.cs inside ML.Samples I received warning tooltips making reference to the errors in ML.Samples.GPU's Program.cs.

Although this didn't prevent me to run the sample, it was odd to see that error messages. Also, later, when trying to run tests inside Visual Studio, I got a compiler errors because of this, and I couldn't run tests. I didn't use to have these compiler errors before, because ML.Samples.GPU was introduced in a recent commit to the master branch.

**How to solve the problem?**
Eventhough ML.Samples has the correct settings to access the sample I was trying to run, ML.Samples.GPU doesn't. This problem might happen with other samples as well.

So to simply solve this problem, a new Program.cs file needs to be added to the ML.Samples.GPU project, that is independent to the one in ML.Samples.

This same root cause must be fixed before merging.
REVIEW_EOF
