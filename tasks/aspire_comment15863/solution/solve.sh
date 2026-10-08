#!/bin/bash
# Oracle: a review that restates every bug a human reviewer flagged, so the judge
# scores each as detected (reward ~1.0). Validates task wiring -- the upper bound,
# not a realistic agent, so it is allowed to see the ground-truth comments.
cat > /app/review.md << 'REVIEW_EOF'
## Review

The following blocking issues must be fixed before merging:

1. In `extension/src/utils/AspireTerminalProvider.ts` (around line 102): `\x15` (Ctrl+U) is bound to `UnixLineDiscard` in PSReadLine's **Emacs** edit mode (default on Linux/macOS), but **is not bound** in PSReadLine's **Windows** edit mode (the default on Windows). Since the extension creates a terminal with no explicit `shellPath`, Windows users get their default shell — typically PowerShell in Windows edit mode.

This means:
- **Unix/macOS (bash/zsh)**: Fix works as intended — Ctrl+U clears the line.
- **Windows (PowerShell, default settings)**: `\x15` is likely silently ignored by PSReadLine, so the original bug (#15587) may persist for Windows users.

Consider either: (a) adding a platform-specific branch (e.g., `Escape` (`\x1b`) works in PSReadLine's Windows mode to cancel/clear the line, and you could use `process.platform === 'win32'` to select), or (b) documenting this as a Unix-focused fix with Windows as a follow-up.
REVIEW_EOF
