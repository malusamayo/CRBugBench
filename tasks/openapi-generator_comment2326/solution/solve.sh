#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `modules/openapi-generator/src/main/resources/elixir/request_builder.ex.mustache` (around line 125): same as https://github.com/OpenAPITools/openapi-generator/pull/2326/files#r263813949

```suggestion
  def decode({:ok, %Tesla.Env{status: 200, body: body}}, struct), do: Poison.decode(body, as: struct)
  def decode({:ok, %Tesla.Env{} = response}, _struct), do: {:error, response}
```
REVIEW_EOF
