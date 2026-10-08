#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `alacritty_terminal/src/term/mod.rs` (around line 1879): The docs say the following about this escape:
> If a "?" is given rather than a name or RGB specification,
          xterm **replies with a control sequence of the same form** which
          can be used to set the corresponding dynamic color.  Because
          **more than one pair of color number and specification can be
          given in one control sequence**, xterm can make more than one
          reply.

The most important part here is that the control sequence we return needs to be identical to the way the color is set, this is currently not the case. The biggest issue is the missing BEL character at the end, so a `\x07` needs to be added here.

The next problem is that Alacritty doesn't handle RGB in the specified format. Instead of accepting `rgb:rrrr/gggg/bbbb` it only accepts `rgb:rr/gg/bb` from what I can tell. Since I haven't written this code I'm not 100% certain about its correctness, but we should respond with what we can actually understand.

The last problem is the part about multiple codes. If multiple parameters are specified (like `\x1b]10;?;?\x07`), then we should print the escapes for setting both the foreground color (10) and the color following it (11 = background). So the `10` just defines the first color which will be set/get and every parameter after that is used to set/get the following colors.

It seems like VTE also doesn't handle this case of setting multiple colors in one escape, however it does seem like it would be better if we supported it. It seems trivial to me to add support, however if we do, it should be added for both setting and getting. If you want to handle that in this PR that would be fine, otherwise I'd open an issue separately and ignore that part for this PR.
REVIEW_EOF
