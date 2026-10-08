# Code Review Task

You are a maintainer reviewing a pull request to the `n8n-io/n8n` repository.

**PR title:** fix: Add credential auth and test for PostHog, NASA, Peekalink, Clearbit, Uptime Robot

**PR description:**

## Summary

Add `authenticate` and `test` properties to 5 credential files that were missing them. Each credential's auth pattern was verified against the node's GenericFunctions to ensure the `authenticate` property matches the actual API auth mechanism.

| Credential | Linear Issue | Auth Method | Test Endpoint | Custom Auth? | Auth Source | API Docs |
|------------|-------------|-------------|---------------|-------------|------------|----------|
| PostHog API | [NODE-2747](https://linear.app/n8n/issue/NODE-2747) | Body `api_key` (project token) | `POST /decide/` | No | [GenericFunctions.ts](https://github.com/n8n-io/n8n/blob/master/packages/nodes-base/nodes/PostHog/GenericFunctions.ts) | [PostHog API](https://posthog.com/docs/api) |
| NASA API | [NODE-2804](https://linear.app/n8n/issue/NODE-2804) | Query param `api_key` | `GET /planetary/apod` | No | [GenericFunctions.ts](https://github.com/n8n-io/n8n/blob/master/packages/nodes-base/nodes/Nasa/GenericFunctions.ts) | [NASA API](https://api.nasa.gov/) |
| Peekalink API | [NODE-2698](https://linear.app/n8n/issue/NODE-2698) | Bearer header | `POST /` | No | [Peekalink.node.ts](https://github.com/n8n-io/n8n/blob/master/packages/nodes-base/nodes/Peekalink/Peekalink.node.ts) | [Peekalink API](https://www.peekalink.io/) |
| Clearbit API | [NODE-2683](https://linear.app/n8n/issue/NODE-2683) | Bearer header | `GET /v2/companies/find` | No | [GenericFunctions.ts](https://github.com/n8n-io/n8n/blob/master/packages/nodes-base/nodes/Clearbit/GenericFunctions.ts) | [Clearbit API](https://dashboard.clearbit.com/docs) |
| Uptime Robot API | [NODE-2732](https://linear.app/n8n/issue/NODE-2732) | Form body `api_key` | `POST /v2/getAccountDetails` | No | [GenericFunctions.ts](https://github.com/n8n-io/n8n/blob/master/packages/nodes-base/nodes/UptimeRobot/GenericFunctions.ts) | [Uptime Robot API](https://uptimerobot.com/api/) |

## Related Linear tickets, Github issues, and Community forum posts

https://linear.app/n8n/issue/NODE-4780
https://linear.app/n8n/issue/NODE-2621
Closes https://linear.app/n8n/issue/NODE-3093

## Review / Merge checklist

- [x] PR title and summary are descriptive. ([conventions](../blob/master/.github/pull_request_title_conventions.md))
- [ ] [Docs updated](https://github.com/n8n-io/n8n-docs) or follow-up ticket created.
- [x] Tests included.
- [ ] PR Labeled with `release/backport` (if the PR is an urgent fix that needs to be backported)

## Working environment

The repository is checked out at `/app/n8n` at this PR's **base commit**
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
