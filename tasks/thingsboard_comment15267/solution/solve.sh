#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `ui-ngx/src/app/modules/home/components/widget/lib/table-widget.models.ts` (around line 456): `constructTableCssString` is shared by four widgets, including `entities-hierarchy-widget`. That widget's root element uses class `tb-entities-hierarchy` (not `tb-table-widget` — see `entities-hierarchy-widget.component.html:18`). After the `cssjs` library applies the namespace, the generated selector becomes something like `.entities-hierarchy-HASH .tb-table-widget div { ... }`, which won't match anything in the hierarchy widget's DOM — so all these CSS variables silently stop applying there.

The other three consumers (`timeseries-table`, `entities-table`, `alarms-table`, `persistent-table`) do use `tb-table-widget` as their root class, so they're fine.

A few options:
- Use a class that all consumers share (or the bare `div` selector without the `.tb-table-widget` wrapper)
- Add `tb-table-widget` to the hierarchy widget's template
- Split the function so the hierarchy widget gets its own CSS without the `.tb-table-widget` nesting
REVIEW_EOF
