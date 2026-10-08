#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `dotnet/src/Connectors/Connectors.AI.OpenAI/AzureSdk/ClientBase.cs`:

This pull request introduces the defect later reported as "Example59_OpenAIFunctionCalling Bug While Executing MethodFunctions". The
problem a user observed, and its root cause:

Error while using the new Connector Function calling impl.

System.InvalidCastException: 'Cannot cast Microsoft.SemanticKernel.Functions.OpenAPI.Model.RestApiOperationResponse to System.String'

A change to the code will be needed to handle <object> instead of strings.

This same root cause must be fixed before merging.
REVIEW_EOF
