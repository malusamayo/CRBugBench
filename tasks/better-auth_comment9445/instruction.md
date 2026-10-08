# Code Review Task

You are a maintainer reviewing a pull request to the `better-auth/better-auth` repository.

**PR title:** feat(sso): support additionalFields on ssoProvider

**PR description:**

## Summary
- Adds `additionalFields` support to `ssoProvider`, matching the pattern used by `user`, `organization`, and other core tables
- Fields are validated/parsed on create and update, and filtered on read

## Changes
- Types: `SSOProviderAdditionalFields`, `InferSSOProvider`, `SSOProviderSchema`, `SSOOptions.schema`
- Runtime helpers (`additional-fields.ts`): parse, filter, and Zod schema generation
- Routes: register, list, get, and update endpoints handle additional fields
- Client: schema option for type inference
- Tests: required validation, store/return, update, and type inference

Closes #9396

<!-- This is an auto-generated description by cubic. -->
---
## Summary by cubic
Adds support for custom `schema.ssoProvider.additionalFields` in `@better-auth/sso`, with validation, storage, filtering, and end-to-end type inference. Hardens provider field handling to prevent collisions and disallow unsafe input, enabling provider-specific metadata for #9396.

- **New Features**
  - Schema: `additionalFields` with `required`, `input`, `defaultValue`, `returned`, and `fieldName`; can override `modelName` and per-field names via `schema.ssoProvider.fields` (incl. `domainVerified`).
  - Runtime: helpers to generate Zod schemas and parse/filter additional fields on create/update; output filtering via `filterOutputFields`.
  - Endpoints: `register`/`update` parse and persist additional fields; `register`/`get`/`list`/`update` return only fields with `returned !== false`.
  - Types/Client: `SSOProviderSchema`, `InferSSOProvider`, `SSOProviderAdditionalFieldsInput`; plugin exposes `$Infer.SSOProvider`; `ssoClient({ schema })` enables type inference. Docs add an example.

- **Bug Fixes**
  - Reject additional field keys that collide with built-in or response-only keys, and fields whose `fieldName` maps to built-in columns.
  - Block `input: false` fields on register/update and require at least one valid change on update; sanitize all responses to include only allowed fields.

<sup>Written for commit 8e4f4d41fbcb0710d80ca4f7b388af5acd1e0957. Summary will update on new commits.</sup>

<a href="https://cubic.dev/pr/better-auth/better-auth/pull/9445?utm_source=github" target="_blank" rel="noopener noreferrer" data-no-image-dialog="true"><picture><source media="(prefers-color-scheme: dark)" srcset="https://www.cubic.dev/buttons/review-in-cubic-dark.svg"><source media="(prefers-color-scheme: light)" srcset="https://www.cubic.dev/buttons/review-in-cubic-light.svg"><img alt="Review in cubic" src="https://www.cubic.dev/buttons/review-in-cubic-dark.svg"></picture></a>

<!-- End of auto-generated description by cubic. -->

## Working environment

The repository is checked out at `/app/better-auth` at this PR's **base commit**
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
