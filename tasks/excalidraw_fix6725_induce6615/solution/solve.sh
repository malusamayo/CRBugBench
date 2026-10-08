#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/components/LayerUI.tsx`:

This pull request introduces the defect later reported as "excalidraw UI goes blank on eyedropper open". The
problem a user observed, and its root cause:

https://github.com/excalidraw/excalidraw/assets/14358394/764c6604-1ed2-4e53-b40b-971d43cf2f8b

@dwelle This was raised for the Obsidian plugin, but I can reproduce the effect on excalidraw.com as well. https://github.com/zsviczian/obsidian-excalidraw-plugin/issues/1157

Screen recording is on a Samsung Android 13 device using Chorme 115.0.5790.40 with a bluetooth keyboard.

When the user presses SHIFT+s to open the eyedropper the screen goes blank.
According to the issue linked above this also happens on a windows 10 device (I wasn't able to reproduce the issue on windows).

The UI disappears after openEyeDropper() runs. Seems to be related to the jotai atom being created at this point. The DOM elements holding the toolbar and the element and scene properties menus are emptied. The application does not freeze per say, for example the context menu still works. I tried React.forceUpdate() but that had no effect.

by the way, why are we using jotain 1.13.1 instead of 2.2.1. I see the current code would need to be migrated to 2.x.x but maybe 1.13.1 is not fully React 18 compatible? just thinking aloud

This same root cause must be fixed before merging.
REVIEW_EOF
