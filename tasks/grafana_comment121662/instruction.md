# Code Review Task

You are a maintainer reviewing a pull request to the `grafana/grafana` repository.

**PR title:** IAM: Add UID, and legacy ID filters to team search

**PR description:**

## Summary
- Add `title` query parameter for exact team name matching (mutually exclusive with `query`)
- Add `uid` query parameter to filter by team UIDs via `resource.SEARCH_FIELD_NAME` (mutually exclusive with `teamId`)
- Add `teamId` (deprecated) query parameter to filter by legacy internal IDs via `Options.Labels` with `utils.LabelKeyDeprecatedInternalID` (mutually exclusive with `uid`)
- `uid` and `teamId` are capped at 100 values — exceeding returns 400
- Wire filters through to `SearchTeamsQuery.Name`, `UIDs`, and `TeamIds` in the legacy search path
- Legacy ID tests are skipped in unified-only mode (Mode5) since those labels don't exist there

## Test plan
- [ ] Integration tests pass across all dual writer modes (0, 1, 5): `go test ./pkg/tests/apis/iam/ -run TestIntegrationTeamSearch -count=1`
- [ ] Unit tests pass: `go test ./pkg/registry/apis/iam/team/ -run 'Test_titleFromRequirements|TestLegacyTeamSearchClient_Search' -count=1`
- [ ] OpenAPI spec and generated clients are updated

## Validation rules
| Condition | Response |
|---|---|
| `query` + `title` both set | 400 Bad Request |
| `uid` + `teamId` both set | 400 Bad Request |
| `uid` count > 100 | 400 Bad Request |
| `teamId` count > 100 | 400 Bad Request |

## Working environment

The repository is checked out at `/app/grafana` at this PR's **base commit**
(the state before this PR), and the proposed change is present two ways:

- applied as **uncommitted modifications** to the working tree (run `git diff`
  to see it, or use a review tool that inspects the local git diff), and
- saved as a unified diff at `/app/pr_to_review.diff`.

Use `git log` and `git show HEAD:<path>` (HEAD is the base commit) for
surrounding history, call sites, and conventions.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
