# Code Review Task

You are a maintainer reviewing a pull request to the `bitwarden/server` repository.

**PR title:** PM-18939 refactoring send service to 'cqrs'

**PR description:**

## 🎟️ Tracking

(https://bitwarden.atlassian.net/browse/PM-18939)

## 📔 Objective

Refactor current send codebase to align with our version of CQRS

## 📸 Screenshots

<!-- Required for any UI changes; delete if not applicable. Use fixed width images for better display. -->

## ⏰ Reminders before review

- Contributor guidelines followed
- All formatters and local linters executed and passed
- Written new unit and / or integration tests where applicable
- Protected functional changes with optionality (feature flags)
- Used internationalization (i18n) for all UI strings
- CI builds passed
- Communicated to DevOps any deployment requirements
- Updated any necessary documentation (Confluence, contributing docs) or informed the documentation team

## 🦮 Reviewer guidelines

<!-- Suggested interactions but feel free to use (or not) as you desire! -->

- 👍 (`:+1:`) or similar for great changes
- 📝 (`:memo:`) or ℹ️ (`:information_source:`) for notes or general info
- ❓ (`:question:`) for questions
- 🤔 (`:thinking:`) or 💭 (`:thought_balloon:`) for more open inquiry that's not quite a confirmed issue and could potentially benefit from discussion
- 🎨 (`:art:`) for suggestions / improvements
- ❌ (`:x:`) or ⚠️ (`:warning:`) for more significant problems or concerns needing attention
- 🌱 (`:seedling:`) or ♻️ (`:recycle:`) for future improvements or indications of technical debt
- ⛏ (`:pick:`) for minor or nitpick changes

## Working environment

The repository is checked out at `/app/server` at this PR's **base commit**
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
