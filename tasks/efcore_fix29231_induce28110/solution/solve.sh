#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/EFCore.SqlServer/Query/Internal/SqlServerStringAggregateMethodTranslator.cs`:

This pull request introduces the defect later reported as "SqlServerStringAggregateMethodTranslator.cs has Size backwards". The
problem a user observed, and its root cause:

## File a bug

If it's unicode the size should be 4000.
This seems to set the size to 8000.
If it's not Unicode, the size should be 8000.
This code below appears to set the size to 4000.

        // STRING_AGG enlarges the return type size (e.g. for input VARCHAR(5), it returns VARCHAR(8000)).
        // See https://docs.microsoft.com/sql/t-sql/functions/string-agg-transact-sql#return-types
        var resultTypeMapping = sqlExpression.TypeMapping;
        if (resultTypeMapping?.Size != null)
        {
            if (**resultTypeMapping.IsUnicode** && resultTypeMapping.Size < 8000)
            {
                resultTypeMapping = _typeMappingSource.FindMapping(
                    typeof(string),
                    resultTypeMapping.StoreTypeNameBase,
                    unicode: true,
                    size: 8000);
            }
            else if (**!resultTypeMapping.IsUnicode** && resultTypeMapping.Size < 4000)
            {
                resultTypeMapping = _typeMappingSource.FindMapping(
                    typeof(string),
                    resultTypeMapping.StoreTypeNameBase,
                    unicode: false,
                    size: 4000);
            }
        }

This same root cause must be fixed before merging.
REVIEW_EOF
