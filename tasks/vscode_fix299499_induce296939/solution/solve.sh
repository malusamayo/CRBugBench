#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/vs/workbench/contrib/inlineChat/browser/inlineChatActions.ts`:

This pull request introduces the defect later reported as "FixDiagnosticsAction: precondition mismatch causes action to fail from ChatEditorInlineMenu". The
problem a user observed, and its root cause:

The `FixDiagnosticsAction` (`inlineChat.fixDiagnostics`) shows in the `ChatEditorInlineMenu` but fails to run when clicked, logging:

```
[EditorAction2] NOT running command because its precondition is FALSE inlineChat.fixDiagnostics ...
```

## Root Cause

The action precondition includes `inlineChatContextKey` (which bundles `CTX_INLINE_CHAT_POSSIBLE`, `EditorContextKeys.writable`, `!editorSimpleInput`). These are checked by `EditorAction2.run()` against the editor returned by `getFocusedCodeEditor() || getActiveCodeEditor()`.

However, the `ChatEditorInlineMenu` is created inside the overlay widget with its own scoped `IContextKeyService`. The menu `when` clause correctly evaluates against that scoped context and shows the button. But when clicked, `EditorAction2.run()` re-evaluates the precondition against a potentially different editor context where those keys may not be satisfied.

The `AbstractInlineChatAction` base class already prepends `CTX_INLINE_CHAT_V2_ENABLED` to the precondition. The additional `inlineChatContextKey` gates (`CTX_INLINE_CHAT_POSSIBLE`, `writable`, `!simpleInput`) are redundant when the action is triggered from within the inline chat UI - if inline chat is active and showing such a menu, those conditions were already met.

## Fix

Remove `inlineChatContextKey` from the `FixDiagnosticsAction` precondition so it only requires `CTX_FIX_DIAGNOSTICS_ENABLED`, `EditorContextKeys.selectionHasDiagnostics`, and `!CTX_INLINE_CHAT_FILE_BELONGS_TO_CHAT` - matching the menu `when` clauses.

This same root cause must be fixed before merging.
REVIEW_EOF
