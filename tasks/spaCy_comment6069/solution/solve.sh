#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `spacy/pipeline/morphologizer.pyx` (around line 28): The `pretrained_vectors` argument is passed to the `spacy.HashEmbedCNN.v1` function because that function takes all the arguments to the embedding and encoding layers together, because it builds them both. The `spacy.Tok2Vec.v1` layer takes in the embedding and encoding layers as arguments, so we don't have this config option.

```suggestion
```
REVIEW_EOF
