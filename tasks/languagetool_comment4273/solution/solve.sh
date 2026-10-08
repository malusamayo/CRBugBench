#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `languagetool-language-modules/fr/src/main/resources/org/languagetool/rules/fr/grammar.xml` (around line 10104): There's a technical problem here. `c'est-à-dire` and `à savoir` are not valid tokens (because they're made up of several tokens). You can check whether something is one token or several tokens in the [Text Analyzer](https://community.languagetool.org/analysis/analyzeText). Try this: `c'est` is divided into [c'] and [est]. "C'est-à-dire" is actually six tokens.
The same goes for "à savoir" (two tokens). These require separate subrules.
I really like the comma before "mais", "car", "c'est-à-dire", "voire", and "à savoir".

"ni" is problematic, you need to be more specific for it:
>  L'opération a été effectuée sans incident ni manifestation.
> La maison n'est ni belle ni neuve.

I think in those cases, no comma is required? Especially before the first "ni" in the second example.

"car" can be a coach/bus, can't it? We need to make sure we don't demand commas before coaches.

"or" will also match when it means "gold". Please exclude those. There are several approaches: when it means "gold", it will typically occur in structures like "de l'or", "l'or", "en or", "d'or", "or pur" etc. "Or" as a conjunction is typically followed by a subject-verb sequence, right? "... , or il n'est par rare de voir cela en été."

"soit" is even more treacherous. Most often, it's just the subjunctive mood of "être".
> La légende veut qu'il soit venu lui-même visiter l'endroit...

Maybe you can find a way to only catch "soit" when it's a conjunction. Maybe at least in "soit...soit" structures.
REVIEW_EOF
