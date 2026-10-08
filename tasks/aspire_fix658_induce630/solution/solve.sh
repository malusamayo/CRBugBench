#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Components/Aspire.Npgsql.EntityFrameworkCore.PostgreSQL/AspireEFPostgreSqlExtensions.cs`:

This pull request introduces the defect later reported as "Add view to Npgsql duration metrics". The
problem a user observed, and its root cause:

Histogram buckets aren't well configured in OpenTelemetry. The minimum bucket is 5. That's fine if you're measuring in milliseconds, not so good when you're measuring in seconds. There is special hardcoding for known .NET histograms, but 3rd party histograms aren't helped.

Need to add views to PostgresSQL component.

Example:
```cs
        builder.AddView("http.server.request.duration",
            new ExplicitBucketHistogramConfiguration
            {
                Boundaries = new double[] { 0, 0.005, 0.01, 0.025, 0.05, 0.075, 0.1, 0.25, 0.5, 0.75, 1, 2.5, 5, 7.5, 10 }
            });
```

This same root cause must be fixed before merging.
REVIEW_EOF
