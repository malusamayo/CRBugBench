#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Aspire.Cli/Projects/ProjectLocator.cs`:

This pull request introduces the defect later reported as ".aspire/settings.json folder should normalize paths using forward slash (/)". The
problem a user observed, and its root cause:

The `aspire run`, `aspire add` and `aspire publish` commands in the Aspire CLI (source code located at `src/Aspire.Cli`) needs to work against an "app host" project which is a C# project file containing calls to the .NET Aspire APIs.

When there is not a project file in the current directory the Aspire CLI will search sub-directories to find a *.csproj file which is an Aspire AppHost. When it finds an Aspire app host it will create a `.aspire/settings.json` file in the current working directory. Here is an example of that file.

```json
{
  "appHostPath": "..\\src\\HelloAspire.AppHost\\HelloAspire.AppHost.csproj"
}
```

Notice the some slash `\\` escaping for the path. The path separator syntax (either `\\` or `/`) depends on the operating system where the `.aspire/settings.json` file is originally created. For consistency we want to change the logic so that the `/` path separator is always used.

We will need to update the logic used to create/update this file and also add unit tests.

This same root cause must be fixed before merging.
REVIEW_EOF
