#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `test/EFCore.Specification.Tests/Query/NorthwindMiscellaneousQueryTestBase.cs`:

This pull request introduces the defect later reported as "Single_non_scalar_projection_after_skip_uses_join failing because of missing ORDER BY". The
problem a user observed, and its root cause:

When syncing EFCore.PG, the new Single_non_scalar_projection_after_skip_uses_join is failing, probably because of non-deterministic ordering.

```c#
ss.Set<Customer>().Select(c => c.Orders.OrderBy(o => o.OrderDate).Skip(2).FirstOrDefault()
```

Translates to:

```sql
SELECT t0."OrderID", t0."CustomerID", t0."EmployeeID", t0."OrderDate"
        FROM "Customers" AS c
        LEFT JOIN (
            SELECT t."OrderID", t."CustomerID", t."EmployeeID", t."OrderDate"
            FROM (
                SELECT o."OrderID", o."CustomerID", o."EmployeeID", o."OrderDate", ROW_NUMBER() OVER(PARTITION BY o."CustomerID" ORDER BY o."OrderDate" NULLS FIRST) AS row
                FROM "Orders" AS o
            ) AS t
            WHERE (2 < t.row) AND (t.row <= 3)
        ) AS t0 ON c."CustomerID" = t0."CustomerID";
```

And ordering isn't preserved coming out of the innermost subquery.

/cc @smitpatel @maumar

This same root cause must be fixed before merging.
REVIEW_EOF
