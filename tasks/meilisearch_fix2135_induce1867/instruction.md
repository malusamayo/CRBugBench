# Code Review Task

You are a maintainer reviewing a pull request to the `meilisearch/meilisearch` repository.

**PR title:** feat(auth): API keys

**PR description / commit message:**

feat(auth): API keys

implements:
https://github.com/meilisearch/specifications/blob/develop/text/0085-api-keys.md

- Add tests on API keys management route (meilisearch-http/tests/auth/api_keys.rs)
- Add tests checking authorizations on each meilisearch routes (meilisearch-http/tests/auth/authorization.rs)
- Implement API keys management routes (meilisearch-http/src/routes/api_key.rs)
- Create module to manage API keys and authorizations (meilisearch-auth)
- Reimplement GuardedData to extend authorizations (meilisearch-http/src/extractors/authentication/mod.rs)
- Change X-MEILI-API-KEY by Authorization Bearer (meilisearch-http/src/extractors/authentication/mod.rs)
- Change meilisearch routes to fit to the new authorization feature (meilisearch-http/src/routes/)

- close #1867

## Working environment

The repository is checked out at `/app/meilisearch` at this PR's **base commit**
(the state before this PR), with full history up to that commit -- use
`git log` / `git blame` to understand surrounding code, call sites, and
conventions. The proposed change is the diff in `/app/pr_to_review.diff`.

## Your task

Perform a thorough, critical code review of this pull request. Look for bugs,
correctness issues, regressions, security problems, broken edge cases, and
anything else a maintainer should require changed before merging.

For every issue you find: name the file and specific lines, explain what is
wrong and why, and suggest a concrete fix. Rank the issues by severity.
If the PR looks correct, say so.

Write your review to `/app/review.md`.
