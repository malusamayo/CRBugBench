#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/EFCore.Design/Scaffolding/Internal/RelationalScaffoldingModelFactory.cs`:

This pull request introduces the defect later reported as "Collations aren't scaffolded correctly". The
problem a user observed, and its root cause:

Scaffolding a fluent db context (using `Npgsql.EntityFrameworkCore.PostgreSQL`), column collations appear as `HasComment` rather than `UseCollation`.

Indexes appear to be generated with the expected collation.

`RelationalScaffoldingModelFactory.VisitColumns` [line 500](https://github.com/dotnet/efcore/blob/main/src/EFCore.Design/Scaffolding/Internal/RelationalScaffoldingModelFactory.cs#L500) looks a bit suspicious:

Shouldn't
```c#
            if (column.Collation != null)
            {
                property.HasComment(column.Collation);
            }
```
be
```c#
            if (column.Collation != null)
            {
                property.UseCollation(column.Collation);
            }
```

### Include provider and version information

EF Core version: 5.0.0
Database provider: Npgsql.EntityFrameworkCore.PostgreSQL
Target framework: .NET 5.0
Operating system: windows 10 (docker from wsl2)
IDE: command line

This same root cause must be fixed before merging.
REVIEW_EOF
