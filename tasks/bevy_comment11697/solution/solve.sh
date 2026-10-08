#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `examples/math/primitives.rs` (around line 350): The `Header` needs to be on the actual text entity. `update_text` currently does nothing since it can't find the entity.
```suggestion
    commands
        .spawn((
            NodeBundle {
                style: Style {
                    justify_self: JustifySelf::Center,
                    top: Val::Px(5.0),
                    ..Default::default()
                },
                ..Default::default()
            },
            TargetCamera(active_camera),
        ))
        .with_children(|parent| {
            parent.spawn((
                Header,
                TextBundle::from_sections(text).with_text_justify(JustifyText::Center),
            ));
        });
```
REVIEW_EOF
