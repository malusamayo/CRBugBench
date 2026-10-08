#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `src/Features/Core/Portable/Completion/CompletionServiceWithProviders.cs`:

This pull request introduces the defect later reported as "Debugger inserts DisplayText instead of InsertionText.". The
problem a user observed, and its root cause:

1. New Console App, set a breakpoint, F5. Do not type in the editor.
2. After hitting the breakpoint, open the Watch window and type an expression.
3. Type "List" and observe that "List<>" is highlighted.
4. Press Tab to commit the "List<>" items.

Expected:
`List` inserted into watch window

Actual:
`List<>` inserted into watch window.

Interesting:
If you do the same in the main editor, `List` is always inserted. After doing this in the main editor, Debugger Intellisense starts inserting `List` instead of `List<>`

This was reported by the Pythia team who received a bug report because their CompletionProvider always inserts an InsertionText that differs from its DisplayText.

This same root cause must be fixed before merging.
REVIEW_EOF
