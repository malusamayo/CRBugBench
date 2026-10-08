#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `src/Microsoft.Extensions.ML/PoolLoader.cs` (around line 103): Copilot noticed the PredictionEnginePoolPolicy actually uses this method to create engines:

```csharp
public override PredictionEngine<TData, TPrediction> Create() =>
     _mlContext.Model.CreatePredictionEngine<TData, TPrediction>(_model);
```

it uses this method in turn:

```csharp
public static PredictionEngine<TSrc, TDst> CreatePredictionEngine<TSrc, TDst>(
     this ITransformer transformer,
     IHostEnvironment env,
     bool ignoreMissingColumns = true,
     SchemaDefinition inputSchemaDefinition = null,
     SchemaDefinition outputSchemaDefinition = null,
     bool ownsTransformer = true)
```

note the last parameter `ownsTransformer` having default=true, which means every single engine thinks it owns it and will gladly dispose it when itself disposed. This seems a slumbering bug actually waiting till we fix the issue with disposing. I guess the solution now passes tests because there is one model they consume without sharing with other engines.
REVIEW_EOF
