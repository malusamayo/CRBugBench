# Code Review Task

You are a maintainer reviewing a pull request to the `axios/axios` repository.

**PR title:** fix(formDataToJSON): only split keys on bracket and dot notation

**PR description:**

Closes #5402.

`formDataToJSON` / `formToJSON` split a field name like `user-name` into `{ user: { name: ... } }` instead of keeping the literal key. The same happened for spaces, `+`, `*`, `&`, etc.

The cause is the tokenizer in `parsePropPath`:

```js
const pattern = /\w+|\[(\w*)]/g;
```

It matches runs of word characters and bracket groups, **silently dropping any non-word separator**. So `user-name` matches `user` and `name` and the `-` is discarded, producing nested objects.

## Fix

Match each path segment as any run of characters except `.`, `[` and `]`:

```js
const pattern = /[^.[\]]+|\[([^\]]*)]/g;
```

Bracket notation (`foo[bar][baz]`, `foo[]`, `foo[0]`) and dot notation (`foo.bar`) still split exactly as before — only previously-dropped separators (`-`, space, `+`, `*`, `&`) are now kept as literal key characters. The existing `[]`-empty handling and the depth guard are unchanged, and the prototype-pollution protection (which relies on dot-splitting of `__proto__.x` / `constructor.prototype.y`) is preserved.

## Tests

Added two cases to `tests/unit/helpers/formDataToJSON.test.js`: one asserting `user-name`, `first name`, `a+b` stay literal keys, and one asserting bracket/dot notation still nests (`foo[bar-baz]` → `{ foo: { 'bar-baz': ... } }`). Verified both fail on the old regex and pass with the fix; the full `formDataToJSON` unit suite (13 tests) is green and ESLint is clean.

:surfer:

<!-- This is an auto-generated description by cubic. -->
---
## Summary by cubic
Fixes `formDataToJSON`/`formToJSON` so only dot and bracket notation split keys; hyphens, spaces, and symbols stay literal. Also makes path parsing linear and treats `.` and `[` inside brackets as separators. Closes #5402.

## Description
- Replaced path tokenizer with `/[^.[\]]+|\[([^.[\]]*)]/g`.
- Only `.` and `[]` split keys; `-`, spaces, `+`, `*`, `&`, etc., stay literal.
- Inside brackets, `.` and `[` separate segments (e.g., `foo[bar.baz]` → `{ foo: { bar: { baz } } }`).
- Fail-fast on unmatched `[` for linear-time parsing on malformed input.
- Depth guard and prototype-pollution protections unchanged.

## Docs
- Update `/docs/` to state that only `.` and `[]` split, with examples for literal keys (e.g., `user-name`) and nested cases (`user.name`, `user[name]`).

## Testing
- Added tests for literal keys (`user-name`, `first name`, `a+b`), dot/bracket nesting with literals, separators inside brackets, and linear-time parsing on long malformed input.
- All existing tests pass. No additional tests needed.

## Semantic version impact
- Patch: bug fix to key parsing. Output may differ if code relied on the old incorrect splitting.

<sup>Written for commit c3b34611bb30e242c670b2793ab8ea8a72143fc9. Summary will update on new commits.</sup>

<a href="https://cubic.dev/pr/axios/axios/pull/11006?utm_source=github" target="_blank" rel="noopener noreferrer" data-no-image-dialog="true"><picture><source media="(prefers-color-scheme: dark)" srcset="https://www.cubic.dev/buttons/review-in-cubic-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://www.cubic.dev/buttons/review-in-cubic-light.svg"><img alt="Review in cubic" src="https://www.cubic.dev/buttons/review-in-cubic-dark.svg"></picture></a>

<!-- End of auto-generated description by cubic. -->

## Working environment

The repository is checked out at `/app/axios` at this PR's **base commit**
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
