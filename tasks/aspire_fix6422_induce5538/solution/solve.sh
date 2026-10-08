#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Aspire.Hosting/Dcp/ApplicationExecutor.cs`:

This pull request introduces the defect later reported as "Restarting containers using docker file fails". The
problem a user observed, and its root cause:

```C#
var builder = DistributedApplication.CreateBuilder(args);

var db = builder.AddMongoDB("mongo")
                .AddDatabase("db");

builder.AddDockerfile("api", "node")
       .WithHttpEndpoint(targetPort: 3000, env: "PORT")
       .WithReference(db);

builder.Build().Run();
```

Here's what happens:
https://github.com/user-attachments/assets/04c3b6c9-78b0-4f38-a701-26eea0f39df4

Here's the console output:
![Image](https://github.com/user-attachments/assets/87d37835-1338-4cb8-94ca-aacd63cea47d)


Additional information: Stop and Start seem to work.

This same root cause must be fixed before merging.
REVIEW_EOF
