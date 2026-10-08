#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `docs/samples/Microsoft.ML.Samples/Dynamic/Trainers/Regression/FastTree.cs`:

This pull request introduces the defect later reported as "FastTree regression samples use FastForest instead". The
problem a user observed, and its root cause:

I noticed some FastTree samples using FastForest, namely:
https://github.com/dotnet/machinelearning/blob/fa62c8196e345de82918469b56c2c6c3b16321c1/docs/samples/Microsoft.ML.Samples/Dynamic/Trainers/Regression/FastTree.cs#L30-L32
and
https://github.com/dotnet/machinelearning/blob/fa62c8196e345de82918469b56c2c6c3b16321c1/docs/samples/Microsoft.ML.Samples/Dynamic/Trainers/Regression/FastTreeTweedie.cs#L30-L32
Appears to be a mistake introduced in PR #3948.

This same root cause must be fixed before merging.
REVIEW_EOF
