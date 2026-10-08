#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `frontend/src/hooks/mutation/use-unified-stop-conversation.ts`:

This pull request introduces the defect later reported as "Conversation panel shows stale status (green dot) after stopping runtime". The
problem a user observed, and its root cause:

## Description

When stopping the runtime of a conversation from the conversation panel, the toast confirms success, but the panel continues to show stale data (green dot indicating "RUNNING" instead of grey for "STOPPED”).

We are probably invalidating the query and trigger a refetch too early. This refetch can overwrite the optimistic update with stale server data if the backend hasn't fully propagated the status change yet.

## Acceptance Criteria

> [!NOTE]
> The PR implementing this change should include sufficient test coverage. A test-driven development approach is preferred.

- Do not invalidate query cache after stopping a conversation
- Create or update a test file that:
    - Verifies the optimistic cache update persists after mutation success
    - Ensures no query invalidation overwrites the optimistic status

## Files Affected

- [`use-unified-stop-conversation.ts`](https://github.com/OpenHands/OpenHands/blob/main/frontend/src/hooks/mutation/use-unified-stop-conversation.ts)

This same root cause must be fixed before merging.
REVIEW_EOF
